Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373361F3BA4;
	Sun, 15 Mar 2026 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773586951; cv=none; b=DBoEmpkiqAxT11DPv+WZofswbRo3weSxvnHZaNz4u1T0Qaef1XQ2v+hpdQr2ZXo6XH1y6yY/K2aLyGUxSG9gVa6WlCnIoYV7Zmz9kqL2RUeeV6dr3AH1m2qNnVRC6rVnBqdSpLAj2ZeAUiWFRD9hywVaVZQKoMyCzYixrFLT/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773586951; c=relaxed/simple;
	bh=xw/Bx++EGrUmKp5M3mbMrE+DbDKoIiuVn1SYfSND5LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3k1Y3t/z3YofidR3rwq79MS2w0fEIzQGjO4abYAAC7IvSxilBEhIz+ypZZeGCt6Z8X0BfNSmRVrBe8R/yABbM3WwGpuPa6NashlkHSFBc+CREtBhuLwI+f13SJmlMSKGrmhcI3wFHr3ok/nQgKpV5C6/NIOWyIS7pZZdPhCUH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Wuzl+2PP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Wuzl+2PP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jquOYx5IQU2MsCVpbAI3QC++nXmh9kwb18xkeNFKN1k=; b=Wuzl+2PPlLOt8ZxlJMvOAU8mPy
	FCB2ctGb5wu0SDpFjkd3hQnVTMz+xcs1WmmXuiCqFIb62yTSLzdUULF+cIpkI65WYpkLA9GKgQUxS
	rR2arW/0lPLvZktdDXdrJpX1AF2ouLj2wk1BJ3PUKynSI3uwYBLXPmL35cWQmtyE6uZgHFwUkdvPz
	dJ3P+tRQyS6Anetk5WyGCf/Najz/yKAj0x7qxy/3etWCMWuCO73dHxMLAkRmp6odgqdPCF64MEWTp
	/Cd5TVzzB3d2JMkQqebyG1hzsx36kmOT3eVQs1bwuMaqedaD46oEuOdFU2YJpLAbD9nnbNjncDYse
	80D2vEMg==;
Received: from [179.93.15.111] (helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1w1myt-00G2V4-Pk; Sun, 15 Mar 2026 16:02:16 +0100
Message-ID: <bf714c83-12af-5c2f-30d3-2741d7a86f41@igalia.com>
Date: Sun, 15 Mar 2026 12:02:11 -0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] pstore/ftrace: Factor KASLR offset in the core kernel
 instruction addresses
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, tony.luck@intel.com, kernel-dev@igalia.com,
 kernel@gpiccoli.net
References: <20260313201010.1622406-3-gpiccoli@igalia.com>
 <20260313162831.32b52b6a@gandalf.local.home>
 <b88aa1bd-5b7c-a31b-fea6-3886099e2fec@igalia.com>
 <20260315100936.33132aab@robin>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20260315100936.33132aab@robin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2026 11:09, Steven Rostedt wrote:
> On Fri, 13 Mar 2026 17:57:35 -0300
> [...]
>> So, are you suggesting to use the ftrace infrastructure in the
>> pstore/ftrace? Well, seeing how mature the ftrace infra is with regards
>> the persistent ring buffer, I'd say pstore/ftrace+ramoops gets useless
>> now heh
> 
> The persistent ring buffer only works when the memory is reliably
> consistent between soft reboots. It doesn't work for any other pstore
> interface. Thus, if you can rely on normal ram being available across
> reboots, then use ftrace. If not, then you have to use pstore. Hence,
> it doesn't make pstore useless.
> 
> I would not use the ftrace scratchpad for pstore, as if that works,
> then just use ftrace ;-)
> 
>>
>> The usage then for pstore/ftrace would be more with other backends,
>> really low memory cases like ERST or UEFI, for example, in embedded
>> maybe. And in this case, saving the full modules name table + offsets
>> could incur some precious memory consumption and/or performance impact.
>> Or maybe I'm talking nonsense and this would be quite OK ... guess worth
>> taking a look.
> 
> Exactly (I wrote the above before reading this paragraph!)

Perfect, thanks for confirming. I think the idea of factoring KASLR on
pstore/ftrace (in a simple way) is then valid ... let's see others'
opinions =)

Cheers,


Guilherme
