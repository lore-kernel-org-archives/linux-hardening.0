Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304880;
	b=Zza0kdAjjfoc0REGoB1gXurZwEhGwvJMXXSvz+1q9+PNQbLZQyHc7SsVGzHASgztgtR7
	 yNDGvVDoipCiVoo8G+mrbrTp0NRAIxUmTsltV1Th3+jmAtpApH1NOzqMZmldvU/t5cRGb
	 G4wLoetATViNrZC2aDsIiNfX+LUeOWs4ZGmJgXY1VKN7ovQgWAXC0MZwfPPM/sdDTVsRq
	 BNpU9NlRRCoNhp9ClaLbSZXq8T7LKpba76aGpjWRowniaL53u7AJR6O7+5WtchBqp57yp
	 XY/o4FaQLErmvVDdpTQvP4ww8a8VA6HA+LO7RTMB4PBmCjpZEf+aq/YOOh/94rvZNcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=r9Pl8QyXylw3efq/GJcZ2H+q3w0RBKBXrliBi80vKGw=;
	b=QEN+wzoEp9lqZ6mAK8Xb84Xtol06hkZZTSVAINN1Aj1wXJ6hKZdu6ENklLthIQzYine0
	 hBZoUUJY9D/JKdvH3xW2CEhhFdbJdfz1NRT8U1juZAEEfaVU0f8aZ50NkE/lQNXPdZycd
	 6+8DBfeEcRmIDyPn/XU3/qC8S20APFvXiT7EuFzkCTHTZnu78vr6ewqJef6Wc4tag8eHd
	 jT4NFeN0YVnP/q8b3fngq5iSyv3rwsCPYBdB0FjrYZQkRur5YG2zlN04WqjssZDVOgYNK
	 YQrVbxDZKTNgPasdb7U4pufuGMy0ZRdw24o1uc4ZQZsFSU+4O8UJ5i5XtAfJHT8jiqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hihSnyLV;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EDD60A3815
	for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 10:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8EDD60A3815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hihSnyLV
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492fcbfaa87so1165550f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 02:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794304878; x=1794909678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r9Pl8QyXylw3efq/GJcZ2H+q3w0RBKBXrliBi80vKGw=;
        b=hihSnyLVB9FjyRlDuAovNuIBjgewXp5dc/cQqEO+qUuZyz51f4E5maO2fTlg9fxjmU
         85A5jq6UUjxbgA5fQlRAE+RvwEwIMtIPPpPJG2jTeCKmaod1hgWq2ZrxpkYS4XPP/Lir
         a7EAw5oUQqDLxyjeJo1wkT+/Rvvj7BX5K1r5AXcLPq5VF0uSW4ArS7/TTmGepGQdebkR
         uNE+5OJLM+e8RzTyICAmiZlySlTFU8Banj+xC2TMXlVF2p/FX4ILu8goir89YN+FD6Up
         XrQF78+wReRB6xrljJv1O4/wTHTIIQePnWNiB1bgTc1wgpVHOCVrzJD21lxK2SoWDnTX
         P5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304878; x=1794909678;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r9Pl8QyXylw3efq/GJcZ2H+q3w0RBKBXrliBi80vKGw=;
        b=yT7uqVKTSV8bKPe3MFw3B11vMB76oAy5Tp0hM/v5ha+BsU8mMcaqrHAWqbam+9fjJ0
         Bepcb5ycfu1ugQATflpMNskUiDBcCaDdtb9OKBksqsAKxN1uCswh+RXwD/xiA68MkpiT
         J2XJx1f9az3HZpuGJt8bF4RR08gOxE3AP0CszPb0chFGFSqvEDCyqLcdmiUEuU5SQgW6
         fIBsZv5PIKH1zoiFjjGwH57r+6c0jV9y0L/OEMdrJuWKXg3arQApDlGSapTn04PMkOOI
         URyNh0OAeHZJVI2o1qVZvrTldVk3XQFHG9Pxhcxp72bpP8oQHqDBpoXOYxAzzr2CL7BB
         K2lA==
X-Forwarded-Encrypted: i=1; AL+hErG9rG03AYewiGkLDNDd0esEZ5F68+XruroYIAcbECSSvv2LhiYDdKzJOMWjWcy+t8/fUGDIMTJx/zuLkILxcbw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/q2peSjVefN9s4Y9dFB9TE08pjH1c015hEZ9np6oCV+wTdjLoI
	PeBwW1PnzRtPk9HxTG35vZzkHFk3oQjAASBWiSCWsTdIWhnylkfMvpYN
X-Gm-Gg: AYBFou3O2vCQmIztMqiwgVVY+pUq+kJakwe6FP33Xqr42mK4gMmwU7QLbO6TwyjSPjV
	7yc94CQsZ2D1u469pjEmJTnjxfHX1jBJcF0IO+jp227PpKkxKnq6muTR75og4eG/foRuVkcObWF
	am/t7ztRc2p5HB2QR44f5kEtymt9RCOsfBOGxRJa0/JKO8DOOx5ljo3oKjy8YWc/QEFZ9zG6PSs
	Cnwingnq/ZXc9z/xQRPqME0/CUW4XVlqocpvqHO6YJonobc/1upDEj690ZibriSXwMAop10XkFD
	k69FZG7qiJLbSmDWwR2ckWZm9dTYTjA3vgsYTsrGzpu1mCT3PuBhGJtbIESkUtk+xRrjxkBAEKS
	pa2Rpkz0FJCgPuPW6zp5oy0MI/aH6XqZyz/5p4fdgQS/80987r3n8bSqYM6E4MENrOulCa+PTd1
	XnwdFD/ZUvqmCfgKLk2MuMqJfw3Y2TIOD5/AkUb8bSg3EdrXPxr0CDe2+BRvWSiwUVxy7ZRX9HS
	/86vOk/hPk6xIqhWqMiAeq5qj3560hBz92CJrDtvj6xjUbjGYTNu5YXBCDbzQystutnZ59/5MON
	jy9NlmKci7cAjKGzXtZL2ZaV1cySNefANjr4uE/LqAtMWz8ggudrLufa51xB3gJ3rO8ImVfCWEX
	IJMgwxSXzW3Zf
X-Received: by 2002:a05:6000:2003:b0:48d:ecba:3cf8 with SMTP id ffacd0b85a97d-49830b9829emr4172839f8f.43.1794304878022;
        Tue, 10 Nov 2026 02:01:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4988f5b1ce3sm2567009f8f.14.2026.11.10.02.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:01:17 -0800 (PST)
Date: Tue, 10 Nov 2026 10:01:16 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matteo Croce <technoboy85@gmail.com>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook
 <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7] kunit: memcpy: Add benchmark
Message-ID: <20261110100116.5c435722@pumpkin>
In-Reply-To: <20261109193925.8a127f2d0afd5429f1f551f1@linux-foundation.org>
References: <20261110021622.122490-1-technoboy85@gmail.com>
	<20261109193925.8a127f2d0afd5429f1f551f1@linux-foundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Nov 2026 19:39:25 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 10 Nov 2026 03:16:22 +0100 Matteo Croce <technoboy85@gmail.com> wrote:
> 
> > Add optional benchmarks for memcpy() and memmove(), enabled with
> > CONFIG_MEMCPY_KUNIT_BENCHMARK.  
> 
> hm, sorry, I must ask "why".  Nowadays optimizing memcpy() is a
> super-specialized thing undertaken by the bravest architecture
> specialists who are unlikely to rely upon a generic kunit test for the
> purpose!

You also want a comparison against the 'obvious loops' (which it can
take some effort to generate because the compiler tends to convert them
to memcpy()). Otherwise the numbers are pretty meaningless.

But kernel benchmarks are really the wrong place.
The 'bravest architecture specialists' are going to test the code
in userspace where multiple algorithms can be tested and quickly
tweaked/dismissed.
You also need a bank of systems with different cpu variants and run the
code on all on them - much easier if you only need to copy a program across.

I also (sometimes being one of the 'bravest architecture specialists')
try to work out how many bytes/clock the a copy (or ipcsum) is doing
and what the fixed costs are.
That actually tells you something useful.
(But you always need to check that the compiler generated something like
the expected copy - otherwise it is pretty pointless.)

David
