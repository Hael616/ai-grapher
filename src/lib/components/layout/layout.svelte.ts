const createStore = () => {
  let pageTitle = $state("Dashboard");

  return {
    get pageTitle() {
      return pageTitle;
    },

    setPageTitle(newTitle: string) {
      pageTitle = newTitle;
    },
  };
};

export const layoutStore = createStore();
export default layoutStore;
