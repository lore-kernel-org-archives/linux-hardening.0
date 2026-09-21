Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D9494800
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992552; cv=none; b=W2+4Tmhp1jgTtythl/5WdWSVMSO5jIUJF3DxlGGK8mpsXIgJYm4u8lqIZjpnWK7OKjcZR3jK28CmlhkFjvHsmGwpopfU0y3TDK52WmxtM9a6lB43D9FOVkdoE1+YZK5iZLvb4jkIL7qLDwtbScxz5sr5HA33P7tRvJNZ68KcNqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992552; c=relaxed/simple;
	bh=YBV2qFNBiBDxmwMg4/gYVlQdwkVLa6/Ny/umX+th+a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYc16x0jre9V8soqd90SJ4zHnDXN4X1k5BfRyyRPFZ4EV5rZL7Jg8wcgUWKMCvt1A6dB2botT86h1+FrhWyrRFBm2kOeD9uKCqO/SE6dFz3lBZwG7qrr9peR6++AiUOX+1S3T83GZEKqh1ABK6s7cx1HSNNFtx0Wq75iidKF/8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYkLfITr; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYkLfITr"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so21430865e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 05:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789992548; x=1790597348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/1AK9R3z2kttD4zy0NklD51ewJDy0/li8YyGBaTfLw=;
        b=GYkLfITrdAUgP+k2PZQaJ3xuVXjhg1TCqeH9r7FvsSMfhJ0XWdj6L28rJSBTeU1tas
         Kfa84zyYoSdtGL3zYB9ZrwaYxhu0oMaPPzdhJ//URpBWj9sydFy8CHgaRwMESG9DGX0E
         pNZEU8XDR7Xjl/ZE9w1zkIoI/VRUXd226DWsc2bAb4zdwCUYN7aMFf125HYRq9B50qH0
         D9NVS9I4vsc9kJ37RSS73h+wLU142gChpqqpzbOQwVC61eRwUToiUR+tnG3keiqmuuCc
         KGW2AgGJ2HcTB9yWqlAd37DeLTzR2QEZ1DZ85icA5Qz0iL+9XEkpw/RKKObEsct9JwbU
         xlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992548; x=1790597348;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P/1AK9R3z2kttD4zy0NklD51ewJDy0/li8YyGBaTfLw=;
        b=hglEL4zPJhaJh6bz0jg8BN8J2bRvmRZQTo3JLBqPWxtSSSwxarVFak99eZSvUBmy6g
         aquv0ewC9K2QrYl+VIGCuJKuaRMLsXBp1bSPJD0SMoyZ+Er+S/XBPlkdX2tUxgxQRW0m
         6j03GTnYxMzQQMwA6o6BqcyoLcSkC14kiTDwAENgwHZ8wqy5e7iuZRVSONsp8lxe7yqr
         XNoXJnF864I5i9ogg3TPTvK6SVHi5k3RLpOwenrhEZrkaNpbBW4P7cE0x2hgrON/I3jZ
         FhTDpb6xJsEAOq7ZWTNEXIxIQeHy/ekvdSD7NYfNVUj5EITPgo1Y95TMLCZFGawxyiMa
         SnNA==
X-Forwarded-Encrypted: i=1; AKwUvByJfvKt+cxH1fTSyDykoCizZaE++vhpYcQPg0l0dnF8B8/eriAXVgtytSjLCqu9V95jhgUdkfg7gzkeh8snD7I=@vger.kernel.org
X-Gm-Message-State: AFuF++n3WGs90S564CJtDBv3s5t6YJCL0ZzrJSj36jlqkIP28lG34a3D
	96UoXbpUWDzzrnkIBbKYYdl+U8L1HV0HzeFm/9tk/4zFVtwywPBX2moi
X-Gm-Gg: AYBFou25JZBw758AKWl9+SUiPL+cQc5XjdUjjaMlP7ficAGgzUYoleWMP1+4rkxc7IM
	bksm8gAjF5W9Ywnd/Q33E2Un8P7bDAJpdxCFn6Wa+XIOwoWU4G/x3a25XAdsVsIjPm/DsWFdVJS
	t4d5vh+IZzGkjdQHn3I7s2XFtqxbkpiGAnACErz/Si8S5IJadmkDnthRdHEYWfpShu0jdYOhsjc
	lFAZIsQRdrFNUkBGftrD62S4ByrOPGdReUwVf6WnjmajMmib3dUzgssJUns6UGyjpj//pRQDmT3
	yGZ8fg3mfPcKiESlHurtXyuEpcPH8nckUpZJYzkWUKcIwa3LbuPyLK2kmBWzL+B9dh+51Nl8/mL
	Ungh6gSSHa1iexDQ9LjxpVqyLu0FdTS/7KeijRoXL8oEP4WZanuYousPPGSnobFQajEm7XSFydc
	ea1soZfP4fHmw+FEm+UImtUNIiDAxvbKU8uRDM1waIqVyJViAIFHpkevUta4O/d9jJUkFD5ARVi
	vsHw0ruzjj15F4L81d7g9C+GND51A+caaNEMiwhBgsX6/rsPqyOvoDk7bgZSYwvB6P2ejP2V+94
	OQ==
X-Received: by 2002:a05:600c:1c01:b0:49c:fc6e:a3d7 with SMTP id 5b1f17b1804b1-49fc5753eb2mr184542645e9.22.1789992547781;
        Mon, 21 Sep 2026 05:09:07 -0700 (PDT)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10273fsm229284935e9.7.2026.09.21.05.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 05:09:07 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <350cc022-2769-4052-93f4-029ef93fa41c@gmail.com>
Date: Mon, 21 Sep 2026 13:09:05 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] kconfig: Replace "cc-option-bit" with "cc-option-str"
To: Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Matthew Maurer <mmaurer@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 linux-kbuild@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 Nauman Sabir <officialnaumansabir@gmail.com>, Tejun Heo <tj@kernel.org>,
 Nicolas Pitre <nico@fluxnic.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrew Jones <andrew.jones@linux.dev>, Graham Roff
 <grahamr@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260919005923.i.879-kees@kernel.org>
 <20260919005929.4077729-2-kees@kernel.org>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260919005929.4077729-2-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/26 01:59, Kees Cook wrote:
> $(cc-option-bit) returns the flag it was given when the compiler accepts
> it, and an empty string otherwise. It was originally only used
> internally for machine bit flags, but it is generally useful[1].
> 
> Rename it to $(cc-option-str), which says what it returns rather than
> what it was first used for, and extract the probe logic from the existing
> $(cc-option) macro to reuse it. Additionally add support for an optional
> fallback, much like the Kbuild cc-option macro. This can be used as:
> 
> 	config CC_OPT_FOO
> 		def_string "$(cc-option-str,-fnew-option,-fold-option)"
> 
> If the fallback is omitted, it is just an empty string.
> 
> Build tested ARCH=x86_64 defconfig with GCC 16.2.0.
> 
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>

Tested-by: Julian Braha <julianbraha@gmail.com>
Reviewed-by: Julian Braha <julianbraha@gmail.com>
