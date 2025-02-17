Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825D21ADA7;
	Mon, 17 Feb 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797295; cv=none; b=RcT0SCWjcDdXasVgKeqWzXRoSh2wmm4tmuMINdnTiZPlxJrxjcYK64C3SPUFSNytPiP0qD8VbyCB3XEX1Y4DNiM6zHMAsOZ8l5ZBIGHPqyJH5gSp4qRscXzLxtwTZ+eM0cf5+tNLTSFV3bLUI3KJb7Nb/sC9hywAQEEjLO4upjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797295; c=relaxed/simple;
	bh=Hk9O6kgZtW5HBAPWDi1ubXQtnoQYa4K3Vipj/XLrz20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLhUjimsb5HiVjdvLx2GPp/efjB71D7Fph6/3IwRnKVEYMHlmCoTQPPAYuaxJI74pwmmDNKUxwZezk/v9vmLkzPIA1PBX+dQ96f2P2tmNHB8DmMZMwkKG1CvDPXDc5hus6XigFlLOie/G3wQpGBC6cl8WotOL0FABlCGfy/z/wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=bO6ALWhb; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="bO6ALWhb"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21E8D442EC;
	Mon, 17 Feb 2025 13:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1739797291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOL9mfk/9v5FRO1VfirUKFrE/whi9WWcvzNJX8maZI0=;
	b=bO6ALWhbXToInNzAwugYrepTD3C+fePro0peaMuYKAJEE3qz90F7zY7uftSaSeTkdCswHs
	MrTrpDJ1FZM57Tzm8SVabRsLlTnl94kLbVKIH7NDR8ZyawZLlbBqpMXWIjnOoC5rvsbO68
	GVO3qzIBDclhusXUotVYOinhVZOKqGBIcM3yad8MBNN61YqEt6ndtV62AqmdJu/xjfqmZa
	7ntQ0wH9q87y8WbWy42Rd38CRgyNvaWCJn0iHeHqSL5InCKdkX7ipQUADuueouPSgSXyhO
	nadEqh1vOOr6Dzy/itC1ersATHYxw+UUccV8/Ita2PvLOxTv+ntMJzQHctCuPQ==
Message-ID: <b5ed8cc5-ae78-42f7-bbb8-8f9d286ed7b6@yoseli.org>
Date: Mon, 17 Feb 2025 14:01:29 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: mm: Replace deprecated strncpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-hardening@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org
References: <20250213141037.50394-2-thorsten.blum@linux.dev>
Content-Language: en-US, fr
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20250213141037.50394-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeflvggrnhdqofhitghhvghlucfjrghuthgsohhishcuoehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrgheqnecuggftrfgrthhtvghrnheptdehkedtieetudeiffekhfeghfdtheetfeeftddvleekgeelieduveetueehgeefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepfeejrdduieelrdduvdeirddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepfeejrdduieelrdduvdeirddvgeekpdhhvghloheplgduledvrdduieekrddvtddrudeijegnpdhmrghilhhfrhhomhepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepthhhohhrshhtvghnrdgslhhumheslhhinhhugidruggvvhdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhhrghruggvnhhinhhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepl
 hhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Thorsten,

On 2/13/25 3:10 PM, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers. Use
> strscpy() instead and remove the manual NUL-termination.
> 
> Compile-tested only.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks for the patch !
It works fine for me:

Tested-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>   arch/m68k/kernel/setup_mm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
> index 15c1a595a1de..48ce67947678 100644
> --- a/arch/m68k/kernel/setup_mm.c
> +++ b/arch/m68k/kernel/setup_mm.c
> @@ -243,8 +243,7 @@ void __init setup_arch(char **cmdline_p)
>   	setup_initial_init_mm((void *)PAGE_OFFSET, _etext, _edata, _end);
>   
>   #if defined(CONFIG_BOOTPARAM)
> -	strncpy(m68k_command_line, CONFIG_BOOTPARAM_STRING, CL_SIZE);
> -	m68k_command_line[CL_SIZE - 1] = 0;
> +	strscpy(m68k_command_line, CONFIG_BOOTPARAM_STRING, CL_SIZE);
>   #endif /* CONFIG_BOOTPARAM */
>   	process_uboot_commandline(&m68k_command_line[0], CL_SIZE);
>   	*cmdline_p = m68k_command_line;

