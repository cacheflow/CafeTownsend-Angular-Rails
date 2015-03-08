# all directives
angular.module('cafeTownsend')
.directive(
  'dateFormatValidator', ->
    pattern = /(19|20)\d\d[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])/
    {
      require: 'ngModel',
      link: ($scope, element, attrs, ngModel) ->
        ngModel.$validators.dateFormat = (value) ->
          pattern.test value
    }
)


.directive 'uploadImage', ->
  {
    restrict: 'A'
    link: (scope, elem, attrs) ->
      reader = new FileReader
      reader.onload = (e) ->
        # retrieves the image data from the reader.readAsBinaryString method and stores as data
        # calls the uploadImage method, which does a post or put request to server
        scope.newPost.imageData = btoa(e.target.result)
        console.log(scope.newPost.imageData)
        # updates scope
        scope.$apply()
        return

      # listens on change event
      elem.on 'change', ->
        console.log 'entered change function'
        file = elem[0].files[0]
        console.log(file)
        # gathers file data (filename and type) to send in json
        # scope.newPost.imageContent = file.type
        scope.newPost = file.name
        # updates scope; not sure if this is needed here, I can not remember with the testing I did...and I do not quite understand the apply method that well, as I have read limited documentation on it.
        scope.$apply()
        # converts file to binary string
        reader.readAsBinaryString file
        return
      return

  }


.directive(
  'emailFormatValidator', ->
    pattern = /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/
    {
      require: 'ngModel',
      link: ($scope, element, attrs, ngModel) ->
        ngModel.$validators.emailFormat = (value) ->
          pattern.test value
    }
)