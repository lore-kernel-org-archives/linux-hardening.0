Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5922820C037;
	Mon, 21 Apr 2025 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745240543; cv=none; b=buEhTpnNgCtVe8IE7eyR4hnBn3ALfFJhE6mSOt0B/3QteWj9G7QrSVusFFh10jUWJCbZgb/zs8Z8dVZcowmq37faeTsONd/nnSA3pGB96ybS5fSdE8E7zMVYExgKZF0okq8u37HD/ldYD6kIl1xbyVPyaqNScPYaTHFkSmc55gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745240543; c=relaxed/simple;
	bh=bq9TctTgx5UnhHGLToD1nmTyePEW6dO6CqXllYYZThY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4fzyCwDNnwfr9ld0zIkuLSoXZ6CGdT1JJJzYBaCrZkECEWnbAhS1uKrs82aevO+RFYxhKBwie84U1Xof7r+SSnvO5+uU5UBdO37tTJjCrvJLbhNcRnjELz8BmbPufxyJTpVFm/6E04973kILYndaEEFd46jXfzygWZSEbzNmZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=kTgSATTt; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="kTgSATTt"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E54843B19;
	Mon, 21 Apr 2025 13:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1745240534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2FNTsgyF2aQ6QtjVQqKA5pPx+bVu/5KrAYYRX8T8Nk=;
	b=kTgSATTt2fIeg8A3cuasn62oe9ZgF4H9IEOs08m4l3Phu6pXJF+iKtNYR1CqIip5/iTubO
	loxnQjilptQJW19uKGlI3EcFzAEaQwzLwCh11PzqQ2immM6OB8IVExWH18vabuWxtgCarM
	J0h7tlX/XZBqBDADD7wq1E3OXAOba3F42A1rbo5h+8zXt+A3n/HwrM1x5pdDvcaKDX9ECg
	pO66sTKCCOqp6olk98qKsUFBtJLbBhlDSF2LrpPJMp662M8E6qq+c3qQoowFZwvaCwkY8R
	5EV/xWxt4RhyfL4cZFPc+GgFpKhVYlbOSuW5wegKWNlHvt08mp+SugICgxFpFw==
Message-ID: <f178cc44-1b97-4e72-94ae-cffa08173a99@yoseli.org>
Date: Mon, 21 Apr 2025 15:02:13 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: mm: Replace strcpy() with strscpy() in
 hardware_proc_show()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>,
 Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-hardening@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org
References: <20250421122839.363619-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20250421122839.363619-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheplfgvrghnqdfoihgthhgvlhcujfgruhhtsghoihhsuceojhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgqeenucggtffrrghtthgvrhhnpedtheektdeiteduieffkefhgefhtdehteeffedtvdelkeegleeiudevteeuheegfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeeluddrudeihedrudeihedrudeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeluddrudeihedrudeihedrudeljedphhgvlhhopegludelvddrudeikedruddriegnpdhmrghilhhfrhhomhepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepthhhohhrshhtvghnrdgslhhumheslhhinhhugidruggvvhdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgvrhhgsehlihhnuhigqdhmieekkhdrohhrg
 hdprhgtphhtthhopehlihhnuhigqdhhrghruggvnhhinhhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Thorsten,

On 21/04/2025 14:28, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   arch/m68k/kernel/setup_mm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
> index 0fba32552836..c7e8de0d34bb 100644
> --- a/arch/m68k/kernel/setup_mm.c
> +++ b/arch/m68k/kernel/setup_mm.c
> @@ -484,7 +484,7 @@ static int hardware_proc_show(struct seq_file *m, void *v)
>   	if (mach_get_model)
>   		mach_get_model(model);
>   	else
> -		strcpy(model, "Unknown m68k");
> +		strscpy(model, "Unknown m68k");
>   
>   	seq_printf(m, "Model:\t\t%s\n", model);
>   	for (mem = 0, i = 0; i < m68k_num_memory; i++)

As we are not using the return value, I think it is a safe replacement.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
