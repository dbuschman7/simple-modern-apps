// ///////////////////////////////////////////
//
//> using scala "2.13"
//> using platform "jvm"
//> using dep "dev.zio::zio-lambda:1.0.4"
//> using dep "dev.zio::zio-json:0.6.2"
//> using dep "com.lihaoyi::requests:0.8.0"
//
// ///////////////////////////////////////////

import zio.lambda.{ Context, ZLambda }
import zio.{ Task, ZIO }
import zio.json.{ DeriveJsonDecoder, DeriveJsonEncoder, JsonDecoder, JsonEncoder }
import Util._ 

object LambdaMain extends ZLambda[Request, Response] {

  override def apply(event: Request, context: Context): Task[Response] =
    for {
      response <- ZIO.succeed(Response(s"Hello ${event.name.notBlank.getOrElse("Missing")} from Scala Lambda!"))
    } yield response
}

//
// Helpers
// ///////////////
final case class Request(name: String)

object Request {
  implicit val _encode: JsonEncoder[Request] = DeriveJsonEncoder.gen[Request]
  implicit val _decode: JsonDecoder[Request] = DeriveJsonDecoder.gen[Request]
}

final case class Response(message: String)

object Response {
  implicit val _encode: JsonEncoder[Response] = DeriveJsonEncoder.gen[Response]
  implicit val _decode: JsonDecoder[Response] = DeriveJsonDecoder.gen[Response]
}

object Util {
  implicit class StringOps(s: String) {

    def notEmpty: Option[String] =
      s match {
        case "" => None
        case _  => Option(s)
      }

    def notBlank: Option[String] = s.notEmpty.flatMap(_ => s.trim.notEmpty)

  }
}
