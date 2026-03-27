Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EB4379EC4
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604211; cv=pass; b=Yzo24zjtmTscpIzqKsNa8xRQrNy19T5nKMIX2Krm+mVMJNK6YnsVWRs59D8H0ig3lf8E+aBOzwbB1fBmR+pXPp+Ch5MsL6P2siPPiy/CNajLPEdbNH905LhvqRcc3/3vFIu98lH33GC5CCzr7rNVhIgHsdpHshPzFHTkX/Ummsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604211; c=relaxed/simple;
	bh=Ke/OXFwuARyPCCa6DSz76nELinx4xlFUrxOXTYo46As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIv2exyEy1SE/tsaWlmHuAuz1XYrBbXx4qBkPHLX9uf3BDbPgrPd9A1oO7Y4o961bCpYlktOS9xY7i3RhlfdY8aPgWKcIlgLinhGuK5akiWQkmM0/pAYmZMLQxVBgAHbTsOfXheFGUMq2aULOu3n7PLkdTbY7e2qNSnCCg297Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MRchHse6; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRchHse6"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so306299e87.2
        for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 02:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774604207; cv=none;
        d=google.com; s=arc-20240605;
        b=SsM8eTeTtVH5tTI8GQb7MmJLYVnUomVAXULoZ5Q4ObsM+QwaHeQ7h2L9oCvLwuU3gl
         zqvdgQpoxBSmAlUSV58rqTnJBaUL4pdpn23eXhfF5OTCF/5+CkMLyJ7ov6g6lsEf8+78
         TeHjwQcJQLTebpZCqa/gmV8ZLfVYsF2MCVyVf7PQQ2W0/rErLn719nTvb9c7FnpqlLbF
         wo4bJ8a0LGV9BeeOxkd4Jo2hdClWPMXDCPMsu6DcAPTBYXf7E4PPRQ1K0aT2Oplg3idc
         PzJ8UjFnQIjUtmVkIRpwz5ZPBKVQp2WnW/9HQ65ZYLENVx3ddl0QvhH0BvIlTVqAcjoc
         9p0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vQ3mg9eu23z1aT+oHgo+d+ZbECCe93Eys36nWJxEE5Y=;
        fh=Ha3hs1rjgQ4xhg1o5vIg3Mvz3hmEgxs2VRaW4PTUQEM=;
        b=Zr3lGJOSkfxytjEggx5x5I/wIvgw3fzahO2ohuMbkT1GpSczHdw3SZw7gEhNwg4Tgh
         RicvncnZOZlzXe0Ffm2qG0VDYV4GLEqZLKgQ8PtFX6iWeXkmmV20HEQ+w7XmxWktwi7a
         0rcEAy04GM53Ht6IAmsCO3wJVeVh2IiTvYy5MQ3pl7JoGQ4RNhntif1p/Jko4Q+GsEkK
         8SJuMNJoVtJhbg3C4j+9fAMUpJj1aQS8mpVrBLTjhV9UwWSxeixuDc1yzaocjthnh5QA
         EEeRZPvoawCqcOXbPEV8/NIYzQNZB7iRfLCAThbqd7WiozptBouI9mjFp0ueVlVJSnNU
         LptQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774604207; x=1775209007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ3mg9eu23z1aT+oHgo+d+ZbECCe93Eys36nWJxEE5Y=;
        b=MRchHse6t8enn0+9qPpBgQCeZg1xtEhgCF8Gb3ll3ymkWi4DsRlPP2JkRJQWEWggSq
         vPIgxsJ8AOyG6VuhpCsl+jqWrDgdBxhm7fmVtWmbYdViF8k/YLnGzXU9FCjjOYnvEI+V
         esyfLUfQm2F0oK5Yu4eEjftmUDtSi85h3VrAJYrs2EJF5kpoaGMg7KT5F6wxcvC1d35u
         XQFZL8Ym6NSc9Z7aqX7ycThueUOV6YAsQ9c0gbyIxeKeqKYOfTEoJtUg4GoX7u3f16PB
         vS19p10Zmqm+aukdOrf6+10P/SGBfV2/SDZoiSw8hnmknm+qRuMlOXvINa72AGFdV9cz
         2BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774604207; x=1775209007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQ3mg9eu23z1aT+oHgo+d+ZbECCe93Eys36nWJxEE5Y=;
        b=B1Utk4EVb9pjgt1Mga6IgeEP/BFhKM9CMt2hFpsuv0w5JeYSi4GGaJxfhT3oyrGjC1
         y/Opn72Zc+/T6WEhs7+ZrsRnzXecR6wwb1rjRBKvCP/zDVT7lazRj+XL6DRdbNgTYsw+
         JJo7z0s6hkOE0f19zW6unfRMZo68Ltq2/vExBpP6Iisi12zZ4J3BhH2tVZ1ZF714VEQ6
         +OOl67lPXh9x2QWC1TLtAKWTTn8g5+53l02YO+9JbwzlK+z+7RTwXTJ/sCKDhTqmlluV
         XnPexX4CS74lQAsu1m+g455QBzIhW2l052W5sgY08sb6qPec4Dp3jnmVu6SmxZnpH5Fg
         yyRA==
X-Forwarded-Encrypted: i=1; AJvYcCXiEQWsJjTOqsJYh2uf5P2WBJ1oJxZT3dolcBxdeFehAxP79h3PxtWcLJ7H8QVWfQWYxtp3tb5sfoVsqGy6fqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMo/lEb8EcIrwTfponhchSeEayfe58qYzvjFIrstBaiLG+HS4o
	F2b3Vf5NkXQO7zelfPhUACB3zRJK4g3T/XzLXXJq9beJeayho7bTwGHqKIPGVTsqNRQAXsAZhQD
	UGzv3uDPDy5Op8/ZJhrJ93CL6PAYefjW1jBxBNlh3RA==
X-Gm-Gg: ATEYQzz2JL2U/EKm/4Q6YMjcM2D+6keeY5ca39qdjvpKwwezmQL0MOr/iXmV5fOvb+f
	M4tDO4GNDhtiWfBGzCxVW+sXyg4pCiRn4bf62iJQNssEv1LmQV6cDnScIpD03jC1fZNf6nyS5RF
	Bt4ctsNOfaGf1CbuwZgVpLKTI8f429Iq71pxZmKZ9hoHhVLbgvzk+CyHCoBQeoDVuEZgfxZBu7W
	Y4dTCTOkIv8Y25sXKnYhXr9PJHMXYWZMGvK4nyWFnsHkfqgr48fv7DAV5+qnzNsVEWa3vuZOhKq
	73Bvm746
X-Received: by 2002:a05:6512:33c3:b0:5a1:2a8:ced7 with SMTP id
 2adb3069b0e04-5a2ab92f464mr620473e87.36.1774604206860; Fri, 27 Mar 2026
 02:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327025849.8085-1-rosenp@gmail.com>
In-Reply-To: <20260327025849.8085-1-rosenp@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 27 Mar 2026 10:36:10 +0100
X-Gm-Features: AQROBzAg20uCmE0k4Nr0ejPhImIl4mAHsa7ydC91HvIBv7u_kbncgPzg9lHjDjM
Message-ID: <CAPDyKFr1SdB_geQD_QmOSpHBfgY1SjMgyfgR_H07iqxN6=WBJA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_test: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-mmc@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 03:59, Rosen Penev <rosenp@gmail.com> wrote:
>
> Simplifies allocations by using a flexible array member in these structs.
>
> Add __counted_by to get extra runtime analysis.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Nice!

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc_test.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 43fdb67d5407..f5c542855037 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -51,12 +51,12 @@ struct mmc_test_pages {
>
>  /**
>   * struct mmc_test_mem - allocated memory.
> - * @arr: array of allocations
>   * @cnt: number of allocations
> + * @arr: array of allocations
>   */
>  struct mmc_test_mem {
> -       struct mmc_test_pages *arr;
>         unsigned int cnt;
> +       struct mmc_test_pages arr[] __counted_by(cnt);
>  };
>
>  /**
> @@ -135,21 +135,22 @@ struct mmc_test_dbgfs_file {
>   * struct mmc_test_card - test information.
>   * @card: card under test
>   * @scratch: transfer buffer
> - * @buffer: transfer buffer
>   * @highmem: buffer for highmem tests
>   * @area: information for performance tests
>   * @gr: pointer to results of current testcase
> + * @buffer: transfer buffer
>   */
>  struct mmc_test_card {
>         struct mmc_card *card;
>
>         u8              scratch[BUFFER_SIZE];
> -       u8              *buffer;
>  #ifdef CONFIG_HIGHMEM
>         struct page     *highmem;
>  #endif
>         struct mmc_test_area            area;
>         struct mmc_test_general_result  *gr;
> +
> +       u8              buffer[];
>  };
>
>  enum mmc_test_prep_media {
> @@ -315,7 +316,6 @@ static void mmc_test_free_mem(struct mmc_test_mem *mem)
>         while (mem->cnt--)
>                 __free_pages(mem->arr[mem->cnt].page,
>                              mem->arr[mem->cnt].order);
> -       kfree(mem->arr);
>         kfree(mem);
>  }
>
> @@ -348,14 +348,10 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
>         if (max_segs > max_page_cnt)
>                 max_segs = max_page_cnt;
>
> -       mem = kzalloc_obj(*mem);
> +       mem = kzalloc_flex(*mem, arr, max_segs);
>         if (!mem)
>                 return NULL;
>
> -       mem->arr = kzalloc_objs(*mem->arr, max_segs);
> -       if (!mem->arr)
> -               goto out_free;
> -
>         while (max_page_cnt) {
>                 struct page *page;
>                 unsigned int order;
> @@ -3099,7 +3095,7 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
>         if (ret)
>                 return ret;
>
> -       test = kzalloc_obj(*test);
> +       test = kzalloc_flex(*test, buffer, BUFFER_SIZE);
>         if (!test)
>                 return -ENOMEM;
>
> @@ -3111,7 +3107,6 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
>
>         test->card = card;
>
> -       test->buffer = kzalloc(BUFFER_SIZE, GFP_KERNEL);
>  #ifdef CONFIG_HIGHMEM
>         test->highmem = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM, BUFFER_ORDER);
>         if (!test->highmem) {
> @@ -3120,17 +3115,14 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
>         }
>  #endif
>
> -       if (test->buffer) {
> -               mutex_lock(&mmc_test_lock);
> -               mmc_test_run(test, testcase);
> -               mutex_unlock(&mmc_test_lock);
> -       }
> +       mutex_lock(&mmc_test_lock);
> +       mmc_test_run(test, testcase);
> +       mutex_unlock(&mmc_test_lock);
>
>  #ifdef CONFIG_HIGHMEM
>         __free_pages(test->highmem, BUFFER_ORDER);
>  free_test_buffer:
>  #endif
> -       kfree(test->buffer);
>         kfree(test);
>
>         return count;
> --
> 2.53.0
>
