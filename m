Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6111CA9
	for <linux-hardening@vger.kernel.org>; Sat, 24 Aug 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724483098; cv=none; b=G+3+jJXXxdCGH86x5VPiORrzRp6Dfaz/U3obpjxofQcABr4yJRUTbFQl5VM/t7l5zv7s+4OHiCt+pQYnKWcZAu4/XeTM0mKIiKkzQbukpfQhWe9NbBkoevSCld5D9siriMymJXGGo44YZNukWlR0ia6gTiP7veH9t4TsUEuEla0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724483098; c=relaxed/simple;
	bh=zmJ/LsMU98MyMwoaOYUQSgvCgHUVLeUMeF8OZLKv21o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=odvn62vASdR7eBKh1LCf4SH6s4foFpfJDS7+VDRIDeVcLaOvpapW7crNVnKVpsLxUu6TyLAq7ALUF5OiGoHesKSlZo4Vze6tE6X7SXdd1K2sTjKkH2QZgWOSfQZBiKaQt6uYZDjQ1vlbhqmhATRUkP4h4lWsZfAE6m5qogirH8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WrSbZ2shSzpVjm;
	Sat, 24 Aug 2024 15:04:10 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 6499F140202;
	Sat, 24 Aug 2024 15:04:53 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 24 Aug 2024 15:04:53 +0800
Message-ID: <dc6453fb-ed20-415c-b591-cbde4ba69af1@huawei.com>
Date: Sat, 24 Aug 2024 15:04:52 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] lib/string_choices: Add
 str_true_false()/str_false_true() helper
To: <kees@kernel.org>, <andy@kernel.org>, <gregkh@linuxfoundation.org>
CC: <linux-hardening@vger.kernel.org>
References: <20240824070950.2014859-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240824070950.2014859-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

As discussed in the previous thread, the coccinelle rules and some 
replacements will be added in the future.

Thanks,
Hongbo

On 2024/8/24 15:09, Hongbo Li wrote:
> Add str_true_false()/str_false_true() helper to return "true" or
> "false" string literal.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> ---
> v2:
>    - Squash into a single patch as Andy Shevchenko' suggesstion.
> 
> v1:
>    - https://lore.kernel.org/all/1deb2bc4-0cd1-41a0-9434-65c02eef77ed@huawei.com/T/
> ---
>   include/linux/string_choices.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
> index 1320bcdcb89c..ebcc56b28ede 100644
> --- a/include/linux/string_choices.h
> +++ b/include/linux/string_choices.h
> @@ -48,6 +48,12 @@ static inline const char *str_up_down(bool v)
>   }
>   #define str_down_up(v)		str_up_down(!(v))
>   
> +static inline const char *str_true_false(bool v)
> +{
> +	return v ? "true" : "false";
> +}
> +#define str_false_true(v)		str_true_false(!(v))
> +
>   /**
>    * str_plural - Return the simple pluralization based on English counts
>    * @num: Number used for deciding pluralization
