Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047338;
	b=Fx5auaWHYUvUHnznJXfqrd8AsoWODp4uUzs7oj4TqbgbBFMj6lQz+ZF+mlJUl+8MVk0A
	 NIW/wg3rEoXr9Sr9gcO/IazW4n2wRdSJle3j27mzh/z6c/joCdz003XOLdmTY7kDCzTfv
	 2ou6ElncS1i0O2IlLOzrfd75lTuielDlDbBjZUqfcpAh3ZD3xkcRPQ8Cegn/3GLHRjeyW
	 sQBZMQ4yXnRJjwIeuh5CxK90e7b1QG3x9bAWxaWgUtSrB/yG9zxltWUFxvcH0LqADLt6v
	 WWO/lyCTrUimdaCeh72mkde+lPmeXe5oAFJlMF9G25C3wwk7g8hn/PQhDCGLfggdJXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dSc8Cce0DahS+PknmXkz4T5pIyv2lKURzT17LCtrd6A=;
	b=qorI1FI96dWmkP8bUDxJm6GZDwAhhloEulApE/YynfN/3HJYjwNt/Myo/6U92Yt5Sv7E
	 c0dWgLCyxdlSGtx0JLAB6Nyn0kebS7Cspohd0zPB7vu3GlzfT25EJxyK5A50uN8+gZfWv
	 qHkugAJ9F+5BoZI4R/7ESSS61+9gmCjPKbWz4luBNIdjr+y268o8AjbhqRyep5TXwfCHm
	 ykihLSAf16XbxiosQ9OEhHdykNzWfuYhujAkjqMujanQaVVxBNlTggnPQnQ2HDl+t8WT2
	 f0pzjoij8T7dFqyzf5S39m+20aG7qGir/PKDKaCndG6rCrqYMLjOX4RxtvJElu6SE7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gIHyWpZ1;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0535606A32F
	for <linux-hardening@vger.kernel.org>; Sat,  7 Nov 2026 10:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0535606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gIHyWpZ1
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2e96be2196bso5094145ad.1
        for <linux-hardening@vger.kernel.org>; Sat, 07 Nov 2026 02:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794047337; x=1794652137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dSc8Cce0DahS+PknmXkz4T5pIyv2lKURzT17LCtrd6A=;
        b=gIHyWpZ1iCEkEzw77nsaKu/5dokLtbxu79KQ+4oc/nYu8jWV75d5EiMPwS0C4oqg7O
         8eQlPtY/D/CRIUpPxdPOcZZ0uvYR2mBJn6JFFVp4GAh68bMGBOJpHsmg6FwGybOLfs5P
         0Lj81vleMhWg3IHz9caCFulGFeHdC1rKvTJXfuWE58b8cIutX1RCtjEPK/wg/8kgP4ls
         08vzh9Aw3v7vPYNZ0tZS9f5eMDwjIjaHZwcKmGwycUYTk1clSKRnon9fxV3hZIxiToXC
         UX8Zn3VE6sy3ANhVHnQ/ZYNeHU6PS37NUfPQYSetckrutcMHO7CUsNhn+TEMfP9ETP+f
         +1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794047337; x=1794652137;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dSc8Cce0DahS+PknmXkz4T5pIyv2lKURzT17LCtrd6A=;
        b=NA1eHOGwDmgMLsWdLNme0M+Al2KkoXf7FC8uSzU5vfZ0n07EWCD2J86cp+OGvGhhXu
         elUNkslwRNEzAKxs3/nxXNaYw2zXFgGdeWWa5kk8XPBh9JzUVPpVgAhewNmG8EcaLsx8
         KjLQ7ICY57U8CxdD1ibluIndT+h9Z2vo74ewceekfBQbdJyNwZ5pC0BeL1lp4mwgFQC7
         5KxjyYIAcq98Zmw8Sx26XMJXryH2hnNZJI1Io7KW2ky4svXg8twUeuWhCHIfjTZe7szF
         zXnpoJJziqYreh/EsuPd7OSXrfmCHE/ePRAXJBJTJgdMd2QcQWJPGE+XvcUv2t6TuYzj
         xzow==
X-Forwarded-Encrypted: i=1; AKwUvBy8UqIKSOvRlZgE7FPOdeg7rh03nDDWc/NpmiJPvVR7L8p/zLyZI0eT4OnQUoyDv/vP0hDsvkYD7EZAZaZWdiM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/05P+ukhuZPvA9RMNBy63noEbo3hzSQeHuyQei/iC6lB0T4j3s
	lmNz4jEC6samP/wgA4yjsatHjXiEz5kb7oEWty8nUsYg8uiKucqf1Z+4
X-Gm-Gg: AYBFou1QfR/naRBeuEaV0yp1PC4IZ9AVeJ34gxFizcasdBUEmTCT3rYA4OelBQJR3vZ
	2qMBIeJu925NnNPzG4GKhUTxKNifb8aasib2uVTtNmbhdR+XR2JI/y4FjvivT4Vh23bWeTtpQtc
	GKP6cpeyp27tXngS+aPViqeU7+9QU4g1yCFyAF67oSSPZyBKT3r/8QuaVuPX5nl1GC2uk6dlIHY
	roQuAxVNUygsdn3gjeRFjYb51Pfb097lATAp8K2o+Za9eBcat9U608HeTX+vA9zqtB/kV+N4q+a
	k90PuFdKJmGoBO7JxvXsXjq+SNZeNKNyeqp4peTOSEi6S8L1AyJIOVtbEN7vG2/6tHurGQti5BQ
	8w8XkD6NnMOnFXNUp2Dh++sBchygB4F/cjXj+AVFtY7VWYxhKUV9Ie6YLH5IWMYly/sAcOfHkAP
	XKxjTFDBTm3gSGOeQHd8Q3cs4ScMzBJMtYn2iX64+AFU+MJguDAD2CwX5Evwu6M42ecrKMH0epj
	qjPTLOtd54zNeIZSOcP9TRT0ckMvAhrm12EikwWi11gvdcyR3QAjCcbBmGtn7xehi1ll8bBChdF
	C/cvcehffQwxyBUjicfs2+nkb6rRFz2vDRN7N0rLHc+gXQkA3CVo6X0=
X-Received: by 2002:a05:6a20:939b:b0:3e1:885f:b4ab with SMTP id adf61e73a8af0-3ebb2751c28mr5214585637.8.1794047336992;
        Sat, 07 Nov 2026 02:28:56 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b58293f83csm122073b3a.51.2026.11.07.02.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:28:55 -0800 (PST)
Date: Sat, 7 Nov 2026 18:28:45 +0800
From: Shihuang Liu <shlomojune6@gmail.com>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	justinstitt@google.com, morbo@google.com, alx@kernel.org
Subject: Re: [PATCH v4] media: siano: Replace strlcat() with scnprintf() in
 sms_ir_init()
Message-ID: <6nxioe2si6ch2vbdfm2sfspwckbp6qp44rgxztnioty3smqxs5@eccx2xwdy3cy>
Mail-Followup-To: Mariia Nikitash <nikitash.mariiaw@gmail.com>, 
	mchehab@kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com, morbo@google.com, 
	alx@kernel.org
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
 <20261107033928.13891-1-nikitash.mariiaw@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107033928.13891-1-nikitash.mariiaw@gmail.com>

On Fri, Nov 06, 2026 at 07:39:28PM -0800, Mariia Nikitash wrote:
> In preparation for removing the deprecated strlcat() API[1], replace
> the strscpy() and strlcat() calls with a single bounded scnprintf()
> call to construct the IR device path.
> 
> This preserves the original NUL-terminated output, including partial
> or omitted "/ir0" suffixes when the 32-byte buffer is too small.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>

Tested-by: Shihuang Liu <shlomojune6@gmail.com>
