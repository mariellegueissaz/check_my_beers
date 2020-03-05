import $ from 'jquery';
import 'select2';


const initSelect2 = () => {
  $('.type-select').select2();
  $('.brewery-select').select2();
  $('.category-select').select2();
  $('.location-select').select2();
}

export { initSelect2 };
