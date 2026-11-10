Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344309;
	b=BlyG80AOTiMDoxHovwOFPugNMRAM5oJu9n2azyjdahjKiKyxj87YzO3c9z/6D8FP257P
	 nwZDf2oHqccVghQ76cvJ4QZYdkNdJ3bhUpUzrltBd/S2HJidEMC1mfccT1G9gVgke96/6
	 SEcOwgv6Nv39qqCzkKpLSnJwwY1Wn5QLNdqa5jxh6UBxLNserlYQ1HG5NR+TcosQWatFI
	 feyNgi1TdssuSdOufuDkqvsUAzJHjXNnsWYV2RH/V21q1iamaiAQK7RsYOmkLcxPep0FM
	 QAgvRcLR025r65NR7dbfURrTHIV3kq8Rzz+dy+6VoxGINEXbUVJnZi1q11NYEbA1x8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kLM4bV8tdm2z9MSR7M8kpnc0mM3tftTsAj/9cIAHpAE=;
	b=4PT30OlSjVyY/OAn4hvwYnm4H1KwBROigw3Yd8gT9UM1K9SGf459sNJruUVe6TKhagkz
	 enUQ2Sl3+ILzbuth2jl82gPG36f7+NCL8oqv+RVoFS0hMrIuS98b8G2TLXqwJCh4eF9z+
	 QdaZ9o8Bb0r20pjYQ5EMnQi/Bz4lJ0z18EskENu8Jiz/iW+rAZju4zon8F2pq4QKWOJT7
	 9gd9P7n+ed1S0gC39vzkGh4zrFIRfZVGbPlMMe0TiGY5iJVX9Q0vXTLxxdg11bpwKSG5M
	 cbWLkr41IrWBbUUab6Aug0EmfC7LGJLNcdswMCc9Cuqb1niAQBtbETgpxEvt8/JchlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="u6vii/wC";
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71401606A331
	for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 20:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71401606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u6vii/wC
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-492f6b7f70dso1683927f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 12:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794344308; x=1794949108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kLM4bV8tdm2z9MSR7M8kpnc0mM3tftTsAj/9cIAHpAE=;
        b=u6vii/wCL34uzAZ/V4UU9sOlD0mAAHVKnWt+MtiUee6XFX3+EtYIBPVbQzyKv84YzT
         EY+NK1L/PGKAo0U0oqq/tBY0docNnoPMRDfJbD6/V15NeP9K8OwjYiosGEJlv6c9M9u/
         aHdIYdITM6DVEzuOIHGM2WXiiByTHo3UTX+UZPsvo07j5LlLSGTf9WdBfRnMJJ0qPSSw
         6JFxP9RyX3PadDCWVHHw/2S32uIea3zAmgznqdBD68xoi1B0ATXoM9Kh6jklmJUwU7N4
         UqYTXjj0uJFf/MZ6gHQ0bR1JNdaaG1+lM7dwvOAx0nKmZhq6ImK7aN7cKBr91ZjL2g2n
         sJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344308; x=1794949108;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLM4bV8tdm2z9MSR7M8kpnc0mM3tftTsAj/9cIAHpAE=;
        b=sMzmvfB3zuq/hzBFRbcDfJM8UQd27xtpW2wwTYF59irTDxZDgECEojLCI3Sv4b9TKA
         gunUuO8ZYTWa0uqFQJ0WkjoFc7KLFwSL0IOYzX9HM6zQIHPxJAALtHMY8h2Ot7zl3JgY
         QWDZgB3+cPY7/uMfyIKqSwGB6fVOcjeoGj2troJLh6wBlK/LtlP1X74uKyZ5I5dhdsKQ
         JO7ErDHAKcPtzFrx2jy+SEAnQL2AIWz3cSB0/vkOzhZZ8mralBfsmv7nldeiNZv6lki0
         JdR65QKNTQUKOyUgW/6bmRc9CEdleE78CShQca67O3OZIr5GC6c0PbbCAATyAucoYiZR
         RXvA==
X-Forwarded-Encrypted: i=1; AL+hErEDqRVf9z4NtLctsSU8RfrosAKGUiKSsSSorR239xUQxn0sJV77715ex69fMIAyNePcpdYrcYJRmdd+t5JJsgc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lAQbno9X8zDAdyZYohN04QlBpUwBRregxoJ0KPk0z1W80JQwi
	IzFrHE6fO8qvJqxXciYJv6qHOEPLS/te6EPG17pH9UduiMVNlw/g23ah
X-Gm-Gg: AYBFou2Fo3OCZXquSMOzwbzxZu5ZDxJmmeIrtNsLUUkGggTIhkZhvQjl8+hwxTO3FD3
	s1IHudTiGOtlxQe4asvMwiqOiCBtrBtX58UjWylROGjZG0M8/fh4qEbJf/PsITCs3yBaFJrKP3e
	ncCP+79BFmVBxq4wlSrXrTPhu8VtJ/AMfFE6a8tWDxgN51u+DuRWWHRsXzOhKzpSKEOjNAo9C8/
	VRiC4VoA22u5Js2q600dNhvqYZCEruUpS+mHDg6WsdR0zBnuEbtlJXK8nYgpg6sTwBOM6KhLWwq
	1KSGCIHGJqMQ4mog+GIlyGOIL6/BewsInlVmqB3yuopFd/OUbtBxuyHzey0Vfw1/kxKdRDTdaND
	xKtVmivCuMoLAYbLzeN9fpb+vCx7M+cmWcnbDPqS4RYRFil8xB5d8q65Y1E5iK9dwlViYv8h89h
	f8HTuYxgR5hUX1q52hj4ApHKHS2ccbbQh/XntesAOBu/kLk+OXYCHaXHDfDpamJ6Ww7wHrGGM1Y
	Z7TlkblnP5+pkJPNd4ubLaDSXfjSqV1nJ9hA6WY1hsFt/bNbR5Po5Bt+D36B+y3Vx8eFLVIsaRY
	Yv5FMG4aELlfOycpeMJ2gwucdyXDQI1CNt1Ezv6NCXSNMqNnABMPm0b/h++TiUtcnbcCPq/WXon
	2idrJQO8keDI=
X-Received: by 2002:a05:6000:605:b0:491:e062:383d with SMTP id ffacd0b85a97d-499c931ffabmr213029f8f.57.1794344307651;
        Tue, 10 Nov 2026 12:58:27 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-499823761f5sm1662790f8f.2.2026.11.10.12.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:58:27 -0800 (PST)
Date: Tue, 10 Nov 2026 20:58:25 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>, hverkuil@kernel.org,
 mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kees@kernel.org, justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA
 drivers
Message-ID: <20261110205825.18b42b0f@pumpkin>
In-Reply-To: <CAPDEY+X=pVsiY5cib8e_Vu3KNW0QNV6hXF+GSLs9gyD8rMXa6w@mail.gmail.com>
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
	<cd073632-0919-4015-8daf-39cfe24391e8@kernel.org>
	<20261110135444.7d8070ec@pumpkin>
	<CAPDEY+X=pVsiY5cib8e_Vu3KNW0QNV6hXF+GSLs9gyD8rMXa6w@mail.gmail.com>
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

On Tue, 10 Nov 2026 10:41:06 -0800
Mariia Nikitash <nikitash.mariiaw@gmail.com> wrote:


> David, I also see your point about leaving strlcat() in place until a
> more suitable append helper is available. I'll revisit the approach
> before deciding on a v2.

I really don't understand why strlcat() got marked deprecated without
a suitable replacement.
The performance of any form of strcpy(t + strlen(t), s) is horrid.
The only extra issue strlcat() has is to do with it doing strlen(s)
to generated the return value that most code doesn't want
(and in pretty much all reasonable cases is actually fine).

David
