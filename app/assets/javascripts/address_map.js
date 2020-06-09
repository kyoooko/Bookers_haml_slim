/*関数の外で定義(codeAddressでも使うため)*/
let map
let geocoder
// 最初の表示で次の処理をする
function initMap(){
  // geocoderを初期化。住所を緯度経度に変換してくれる
  geocoder = new google.maps.Geocoder()
  // ジオコードオブジェクトを作成し、geocode()methodでGeocoderにリクエストを送信。addressとresults、statusはgeocodeが装備しているもの。.attrで住所を取り出しgeocodeメソッドの結果（緯度経度）をresultsに入れてる
  geocoder.geocode( { 'address': $('#map').attr('class')}, function(results, status) {
    // ステータスがOKなら
    if (status == 'OK') {
   // 中央を指定
      map.setCenter(results[0].geometry.location);
   // GoogleMap上の指定位置にマーカが立つ
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      alert('[Your Map] 該当する結果が見つかりませんでした：' + status);
    }
  });
  // 該当しなかった場合はNYが表示される（下記ないと表示できない）
  map = new google.maps.Map(document.getElementById('map'), {
  center: {lat: 40.7828, lng: -73.9653},
  zoom: 10
  });
}

// function codeAddress(){
//   let inputAddress = document.getElementById('address').value;
// }