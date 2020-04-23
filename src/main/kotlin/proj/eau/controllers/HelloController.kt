package proj.eau.controllers

import com.fasterxml.jackson.databind.PropertyNamingStrategy
import com.fasterxml.jackson.databind.annotation.JsonNaming
import io.micronaut.http.annotation.Controller
import io.micronaut.http.annotation.Get

@Controller("/v1/hello")
class HelloController() {
    @Get
    fun getHelloResponse() = HelloResponse("Hello World, Elnathan")
}

@JsonNaming(PropertyNamingStrategy.SnakeCaseStrategy::class)
data class HelloResponse(
        val messageText: String
)