Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912005;
	b=yIk4o76k7J99DK4QRya5PKx9Cr7GZfioztumBJY6+ms/+eizlUabPIq72ImUKO68hkqk
	 SyZmCh3RTSMlUljNoo7SZ/oPvIrFwCynKg+CYkX2Juv9Gs2PxJkcMaywGb3Qbv7Xvk93p
	 YcKV3zk+LhO/MIXNLvhb4slJPqzQmCLo5rV/A6sZrK7fE7a9gDv+rHty6pkg+D52gZRml
	 OPfQYCDviQe0BcXI8g7esA11KyaW0hC8vcdboQEfK3FceF4CguYQbOTC6RVhmK1bc6y68
	 PCeAV2UHWBGm73CJhsLhk9sbICnTpQhfd1HBsQSV033UtiKkmzMrRJimxUbOiHcn0ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vyz8X2IVMnrruurpCtF0gJRtd7l1YmKPgdLWxJdXL4A=;
	b=yQy4k/VuNg1/0gax6gqn77SLxYoIaG6NUNvAQs+g7Zb1RKVNYfDeUACEQ/GSqiZ6MW4x
	 XrWcj9AKo6aiTuT+nhetvKSSeAIPSABTzb6XVb+3SpMPtaA90bAIN4L9dOn64a1R4VXy7
	 fMchzjfdGp4LX0R41Hs8lJNkxhoSTI+qKlnnthneQ5BoSIY9iVRVg+uiP8+o18Cl+LF6q
	 4Qdfc02xLMdc5usnx4xswAXogw5oAe6Ou/TcWEwv5eqzQKNCRO63Y/WNZy4h1G9sTtYdb
	 YMh4ymotjTqD07w2Ve5+5Kzfv8PqlVqRR/Vs91ylpyui61ucTJiiJPP9HlQpBSToESQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ik3I7FnN;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC59606A31B
	for <linux-hardening@vger.kernel.org>; Thu,  5 Nov 2026 20:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC59606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ik3I7FnN
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a214af2076so17281705e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 12:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793912003; x=1794516803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vyz8X2IVMnrruurpCtF0gJRtd7l1YmKPgdLWxJdXL4A=;
        b=ik3I7FnNvyvNyXzPAbpplQApSSJoH/llqQRkI3xGINTremiplDSXi6YBQer6lGZu8c
         gX1breYwuVaY3YKYJlIy3/HHkA3zXXWuXnBz0OTL6e3kbaXi39z4hU2SfgLI7HgKmsck
         5Yrr8iY0JHBD+sTrCp4j5+Ks541puJOaiG1gymXQEuXgPq/u6pFsBJhLI7v6Mb9QhdwQ
         XXQXzpUt88RNiK28jAo7OjbW+hTwUsHMxFHE1doSx26mRvXzGTGI/8aoGVDyJ5KZb43M
         vFRyjtvfpH0BakxJyCw/diLAh94YtNoAEuOIeuT/sqk1VsIQhbx4N807HdNrm2n0/u+N
         KpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793912003; x=1794516803;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vyz8X2IVMnrruurpCtF0gJRtd7l1YmKPgdLWxJdXL4A=;
        b=qmKze4ufAfbxlXsB0XVKvYsnfFmmDLMzgtWNllQW2+porfoUChmAfjV/yEfE9Yl7fM
         Ms0WRjG0aFfD38obo5H0IRKdymgjS1cfaNqVRRlIdiZ3CC0ev67LLvJ35KzIWlFV/YGi
         LzVFTBw1oyplKYNlUk8FQRC4C6hmZNjWGTr5lQdfHvjnMEBRZpq1aSn/KhPuVqD7lr0i
         FKhnUkDzR/x7c5QchFXFrkp4aO2V39EFm9MvvxICb1A1kJOYnWM+hJgqVfLhp7FMyOSm
         1DJfL3eA4GMQOTSEcB2jV+aHWiQI74ScRLrsvKXL3dfAxjLJzv5+2168wTaf7DE7MYHu
         6KPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpAXd2fM5rBcrlrkZBD1WNqEs5rJKAKKrD7EXhyBL2bdrbDIVijZlrru5B6BS98w1m/Q4XBtsIp51MNd4qI+g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mi6FLBjORmASKVO7M2lEy7kxx3IR2FoJe9Hb32hj6zjHbAUFb
	snB7D2Duf5v2laLXXwuOtbd8MJlU/WB8HkrbPW/ajnDnwqJAVUaXyHED
X-Gm-Gg: AYBFou3l6tHUO3BkyE4Waa+fba1HuxG89ZJtbArI+T0YbYHpzszUCXvn77JrtiXb9Lz
	B+cbz8PCXzjAdqrW6pmSicQBnmcrCbxSYK7Tpa5G5X4AWzXnTDkTBJOVOPzQswRragKFk4OvoPC
	Px+V5l7Wdqvl3g18o0tMrVaHNS4w5avEzm1iUjBMEx4rHhXuXcoPsZ2YDYr05f23VeZfcpPwJSi
	0QPWUm4RIi4XegJLXQRNIDSU7+f+syWy0N8MEHS4mlJ3YcGA2Otb4K9ovKpP/vf+gDZfgEhMLqA
	n2PcZ4bRjL8S8b5fWvN3gLrZXebSJV2pLAiHA59stLxGHGywViqQNxdSpJFEELza1wOdLQwHPa/
	EYyjhBI4pBsUbX08wEl99CB/T1iJXbL2bc3bJTb8eukDj3Nt7pOviDY3wtOZuKJXRrzVeSudcSk
	kejjrkw9MfqjYmuzOMQbpOc6RLIkqnyXd1Im6WMxDakHwfTgXyCB2JdF++pHQwUlkA2lxLjFkkV
	2xwCKSLW4BLx6JA5zIn8kVjg4HurG8D/db/P+n5X3Uh6R+/wz7DSIBIh4txS1mqjXuY2zucsH3f
	Rwz3iPHDoYqrkgcRlwM65n6MvtXAclj+fRCC7CtOkdzDeBkQPhJTkyFVHd9niKWztMEHlh7ZRqK
	g0Y5pNBM/AA==
X-Received: by 2002:a05:600c:4f81:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-4b6de69168emr4225715e9.20.1793912002832;
        Thu, 05 Nov 2026 12:53:22 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4532916f2sm167407535e9.5.2026.11.05.12.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:53:22 -0800 (PST)
Date: Thu, 5 Nov 2026 20:53:21 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>, dmitry.torokhov@gmail.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com,
 morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <20261105205321.7b303231@pumpkin>
In-Reply-To: <auxrRmyg50gvP1HE@devuan>
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
	<20261105112813.13210334@pumpkin>
	<auxrRmyg50gvP1HE@devuan>
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

On Thu, 5 Nov 2026 12:49:59 +0100
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> > Personally I think that while there are issues with strlcat()
> > (mostly to do with its return value), and that there are often
> > much better (and faster - so sprintf is out) ways of getting
> > the same result, the deprecation really needs to propose a
> > sensible alternative (not inlined strlen() + strscpy()).  
> 
> One alternative would be to add strscat(), with the obvious internal
> strlen(3).  This would be a drop-in replacement, and wouldn't have the
> issues of strlcat(3) --mainly, the DoS vulnerability which is
> consequence of the return value, and also the more difficult error
> handling of doing '>=sizeof(...)' than '<0'--.

I've had thoughts of a more general function - but I've not tried to
write it.

int str_append(char *dest, size_t dest_sz, size_t dest_off, const char *src, size_t src_max_len);

Where dest_sz is usually sizeof(*dest) and the header can substitute that for
  a constant zero.
dest_off would similarly default to strlen(dest), if -ve the function would
  return that value immediately.
src_max_len would be used for an effective strnlen(src, src_max_len).

The idea would be that calls like:
	char tgt[100];
	len = str_append(tgt, 0, strscpy(tgt, src_1), src_2, 0);
would append src_1 and src_2 in tgt returning -ve on overflow.
(Further chaining would then work.)

But, as I said, I've not tried to write it or see what it would look like in use.

David
