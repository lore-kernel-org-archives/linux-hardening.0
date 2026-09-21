Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814B833F5B6
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993641; cv=none; b=rLLtMoIPazCCjGFoHk3foXipKcxrbkQdvJaoMEdbrQZvhCGuw0I9J5V4+QCrL2b2CWGD5wyZ6GGs0lz+UJHgh/eCNahVJUajc3rQ3ej+EvEWxLTiF7ZcLreRviTlTzBCw1GW+Pz1pneEpjF00RRriNMtbuZkv8X9N4cCa8W/y6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993641; c=relaxed/simple;
	bh=h0ztzmVkmFi182vK/4CXALOrPc95bqF2GcrR2KyPE3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmeIixaY3emhrDxdrVaD0lRlUuvm6fzs02/WjkrcRIgjTnXIe225pdpxVaDUdFYuR1pDNiykJYU/8uU3vEhz22Uc2KXT2BmH7rdFm5OUAJTCLkKF7hK9qYi/nvsJTbeGVkXA+m35bZUcnTp/0uWimZG1HIiQ92G/VGeXPRV3QgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/U6Qgw5; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/U6Qgw5"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so13420515e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 05:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789993638; x=1790598438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4XfZKnWUQ5NoSIU2RczdWWmmxdsdSPbCtdDyKZ2CKDM=;
        b=s/U6Qgw5XWycYh6rw+Z9xWe9+zR9bIC27ScQv5jactE5GzvdPQv6jhisa7PAhfgujD
         +sbOWg455mp57olvUD1Bz/uW8KVokS3n/lm3bOhYCgLLF4GliLDi3IVE9U8cYdRt0F/V
         +TMs7slWt2LR7s20qZxIdVgJxsavgxdK7WPK0/os1W2u+K7SBODU8EG6k/2fJaWyV2Jh
         /GQmOO4Y9m4s7yUxdR33Fh5z0S+hy8dg11XaNA03U/X1DH7RMpqhXRiY2FfvPZJvhyEI
         Asf7HXoFwMRILnA5CaztdyGSN4ywRrJhrN7KhR7CmWi754ShAINoB3la8Z1O+UygZaT5
         zUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789993638; x=1790598438;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4XfZKnWUQ5NoSIU2RczdWWmmxdsdSPbCtdDyKZ2CKDM=;
        b=etTS+6tTKYdAyl4lEmMLx3x5kzbHkr3AGIaVEUuErF27kOK+ySuuXWgye17ZV6fCFb
         8Mb2Gx/g1nLxhdpPiyvJQvjIOl3PhNkMx+zoqMQ1vaKHoZpBzbauk4IyZaJnRhb4xMud
         Wznb6Thf8IIBkHo96C0CUM6rYXJIJpVkXziUloZJLt75tsUodIuCUoc5LadRb6fhsdM1
         x93W4SWW4W41zVNVm8a1yqfEX5K/lhvV1qsFFc/OMXSR1oIqLQsWMffl3E4MD82N5LG7
         ZqKIplv9xQGM5Y2ERQQOo+gXrKW/78HXnW2LofLL0LzFJFeNdncYKjcvF68z5DFYr84z
         FtXw==
X-Forwarded-Encrypted: i=1; AKwUvBz/I6dpibRXG7mAmqmzS+i0OeDkTn2MTs84l87Eh2K6ySeLA6iRzC9/FhuBwXVb7qAFyHG5ZZLMQOAbgg3tiTc=@vger.kernel.org
X-Gm-Message-State: AFuF++n4yiZ6vIrFx2PuYG710aaWyltPkcVa9Pcb/k8NJD6rXtEgMc+j
	HJqDcZTHNl48DKpgBR/DYQSAq7eXUK5J1qpnxz4jCMaypaAGxrlX7yBj
X-Gm-Gg: AYBFou3ksn6fpdfYlKCRCqTnDG59g8HD9yp+62RTGb5zEOn73SbZ78XBx+SzXAdgxZP
	ytFYP9pyshYXQ1t2/QAiOPVHF9MbT8626BLUH08YdPqKVOu4oO/LjogG84JH1KDyZ8Oo23XHSVL
	EqSMICYxsWvKLd4Z9x7Q4rx3eumTC2e/wKKO2RPemOqZ++KHOlOwGTRj4GzEQjaxhFDTMxl9CA+
	YCK7Ul53NXbG10LM8iB6Su59zWcLTX5dV3GGrMJER13aw7O02BBSsplTkFKoJvusV3xU/Lq3fQH
	R53kqSLwjVoBDYakhEa6jbV+tFWNEm8wGhmxtijy7w6NDtBRQxT7NDROx6ZLgv4ADVWjwdHXNvY
	+a3xU/RKo9jbmuFNhwP8bbwYxrwoEDr5OG1VQbYRWr2iTupWtuazPrTzj84KBPfrsL/u1PGqdVD
	P8UnJz4g79I28w59Qq/LoifWIcHvE6XDohDJ3eAilERHRciGz7rVHocmWb6HpFu6iv04i9C2Nzv
	wLY/j03v25EBK/I0b8FUxjKtBuKx3dPK809mwOMwMm/fbTapn/0knnPCm3ij1GdE8rR
X-Received: by 2002:a05:600c:3150:b0:49f:ce78:3561 with SMTP id 5b1f17b1804b1-49fce783619mr88015405e9.18.1789993637337;
        Mon, 21 Sep 2026 05:27:17 -0700 (PDT)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd103325sm264478965e9.9.2026.09.21.05.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 05:27:16 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <e95d2eb8-f857-4b0c-b64a-d60ad5a10511@gmail.com>
Date: Mon, 21 Sep 2026 13:27:15 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] kconfig: Add "ld-option-str"
To: Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Matthew Maurer <mmaurer@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Gary Guo <gary@garyguo.net>, linux-kbuild@vger.kernel.org,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Vegard Nossum <vegard.nossum@oracle.com>,
 Nauman Sabir <officialnaumansabir@gmail.com>, Tejun Heo <tj@kernel.org>,
 Nicolas Pitre <nico@fluxnic.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrew Jones <andrew.jones@linux.dev>, Graham Roff
 <grahamr@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260919005923.i.879-kees@kernel.org>
 <20260919005929.4077729-3-kees@kernel.org>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260919005929.4077729-3-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/26 01:59, Kees Cook wrote:
> Add the linker counterpart to $(cc-option-str), sharing a $(ld-probe)
> with $(ld-option) the way the compiler macros share $(cc-probe). Like
> $(cc-option-str), it can now be used as:
> 
> 	config LD_OPT_FOO
> 		def_string "$(ld-option-str,--new-option,--old-option)"
> 
> An omitted fallback expands to the empty string.
> 
> Build tested ARCH=x86_64 defconfig with GCC 16.2.0, and checked against
> GNU ld 2.47.
> 
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>

Tested-by: Julian Braha <julianbraha@gmail.com>
Reviewed-by: Julian Braha <julianbraha@gmail.com>
