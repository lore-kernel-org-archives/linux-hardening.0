Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810019;
	b=AasjZzrMQw6wwCvuNsqNKKUEMHMsk8zGaDi5Eeu8dX7jHPn/qWBAvL0pxX1MgDXknlED
	 PXFGPC656z0RO9E6xB21gvqXmz7M8yg5VPFI6o0k9URW7SnudWv1kjlqYjxhSuEOw2qEe
	 LNrbYMkPbQyWo5tDz9rQgabrNfUWvceVwivziC+hK/mpQZtzSrdqsi7AX1fJU3jypy1h1
	 wXwPDC1hZa78vfV0v9vtVrJCUNTBbpy5zZ/j/dGH9cI5S5wRKpip6Enms25D7o1v+f6li
	 lIjvRQWiEhiu2EaDQL+36sB4qccUqeY/hnb876euWIc4V8elhcwnu72+zpdjlWkw0ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZueyWNpbGIvjsd7Apf22rsrjFkb0XJaz8ncfgP1uRU0=;
	b=KFLdPSGaXV9MWDhwai2JDVhlNIN2cUTTxqq8h3vOJB7MnzlA6vjaNOyln3ti6jtCJaDd
	 OTxaNCoI9Fx7QUrGicxfZAyqNXokCLGVMsWCFQAi/TaYpkRdC6nse1jGu11/i2RXc8csU
	 qkoNXgJvNtg7yKtwaVEy1jpt8KuLgkqg90BJ5ABIsNtiRisxFsyyGGyaa/0Od63rmlO+6
	 DOqXdfysyx6YmK8Tdt/Q7uABrsPLBBbXGIim0ivUWc+af5VuMVTNC7kjLN4d+B8VETPbs
	 +aQtJ9WYkDsEsoiWl5skLRn8ulA0PTOw6br1VDZalfYMMeOlA8qDnr++NfENyLtZxIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oyc5+OS1;
	arc=none smtp.remote-ip=74.125.227.133
Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ECD606D803
	for <linux-hardening@vger.kernel.org>; Wed,  4 Nov 2026 16:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64ECD606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oyc5+OS1
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2e7c8213b09so3365745ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 08:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810019; x=1794414819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZueyWNpbGIvjsd7Apf22rsrjFkb0XJaz8ncfgP1uRU0=;
        b=oyc5+OS1YhxQamlQ+lMzRkTUgMsruE6SCyj731QUPB6nYUbiCQDd7OVb6Va5fCTE9q
         4TZ5+JMcKfp8TQ+TJB+OJMb0cbxVqVq4K21Hjz7pDV3PqlJtaNIEzxTOveAZyikMFV3i
         BldWwTeClw1Zrpy/7gJYKNwBXh9oy4xQ17OB22xMz3L+D1DRcFqrI+MQ9kAbt++EfMXw
         6DYRR5BNlypqrvA6env13DORLqZJhLL5FoO3a4tM70AUC503ukdAs4456c2xuZyujgsP
         RgSgBRWDpSmqpu0djmLQJbKj/KSnsjyPxv9yIhgZkG9YEh9A7Z62TRi9H2Ij61n17q6a
         utTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810019; x=1794414819;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZueyWNpbGIvjsd7Apf22rsrjFkb0XJaz8ncfgP1uRU0=;
        b=JFIsRV0HkA2e6SyqMo5Z5wOFq6vqqABQ2gIGe5S/1102Vp1aP38qrTl7Rr588pwESL
         Ju3R4HND8d0NXjZyL1zp4QKy82El5OPsTKQQ0A+z+R3hr+WxTNcboOknpTLd+vMplhh3
         2EYMAnPjjeMlIQ3ks98nsBJ0jbGM8aa7H5cqohkeckSI+dwKgwSAaLtp4Ja6Cblgzm7s
         VwHKqswYt/cymKf2etEbOiP11xLaO/CNkZqVhcucGgbI74RIVj3/snhQp1GRSy5Ng09Z
         Wc8ojQUG+UrZ3SGiieSce+wwOuPLjBUnF1+gWgYjyUCzCYTSC16GjZBSJkWE9f3jIfDu
         /0bQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3RzxsgayDKOS0EAVx60DODwrdzKTK+dxuEGSDRPnk1Mas2325tZkOvlZGgyLTYYwjcSoraOtDdXoL2QYf5fc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ldvBH2zJvP3CpmRri5lIxyhftSF+VBrkqEo5IapRPOHt2Rsz4
	n2fM/PXKQXaKiOBnh6JOdYgakEKQHpLg6Ql6mJQAgu8OqmhYbgCIJAZZ
X-Gm-Gg: AYBFou3SVOq3BPHSpZT5eOEh0jfyQOdw6vQG+xbbfuWf3j2lwKGg+0juL2B/cEb2nx1
	XYH8GONymr0oSBclH/gFi5HtqqYaM3xJ55/6+mAnZRl7vwH6lXEKsysz5rkLYKYPYysqyPK+rUs
	PVk96z9nuHwuYC1aTC6fkveeB8Cl7bMqvHcmjxTOSlKlpDG+VBFiX9POfoIctgYXpoUUzu0oFFM
	pOsJmtdEDRLaZuD9BMOU6c7sSY7z6GsO7scI7uHIS4ii44ZmL9AboH/9ieOC+l+r1YXApX3P+a3
	XFsb2lZDoAMxrYxV2/KPmYdL1paNR/n0G5RICBNfXMf2mH351c+o6evFXli/0KD7C6ioDx11nJk
	c1XJFDoV8iQOAV0wivgt8AWI8vq6JTDrnAvdkIvRNWKJns9QrSRqsKQ2i81FuzltXR9r4p0GeNU
	885qlaFmw5D1Ky09jxuVhX+HbxgGGC+siItxNJJUmjujHD977TQ/OcPyb2mDNhx6T3QbS9QUrNf
	tWHvkrhp17DfX9u2pyNteAloRsxP9O/THzc0oS83OPB3qDEqPhwk+NgNMiC2tD4CvbEAOAohaa7
	BCWJzgBR/ptby27IrnS8G6ISfd0MRn8uMGWrDdjcGckYP7ehGdup+8A=
X-Received: by 2002:a17:903:2ec3:b0:2d9:464f:d45f with SMTP id d9443c01a7336-2eb364025a8mr153213775ad.5.1793810018654;
        Wed, 04 Nov 2026 08:33:38 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0922b86asm9967835ad.76.2026.11.04.08.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:33:38 -0800 (PST)
Date: Thu, 5 Nov 2026 00:33:33 +0800
From: Shihuang Liu <shlomojune6@gmail.com>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: siano: Replace strlcat() with snprintf() in
 sms_ir_init()
Message-ID: <hjwpt5mf7bows633pol5hwmz3uxwhl3fhjupsertv3g7j5m7ya@2rmgrywzhjyh>
Mail-Followup-To: Mariia Nikitash <nikitash.mariiaw@gmail.com>, 
	mchehab@kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com, morbo@google.com
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
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
In-Reply-To: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>

On Wed, Nov 04, 2026 at 01:02:39AM -0800, Mariia Nikitash wrote:
> In preparation for removing the deprecated strlcat() API[1],
> replace the strscpy() and strlcat() calls with a single snprintf()
> call to construct the IR device path.
> 
> Both the source and destination buffers have the same capacity,
> and the return values are unused. This preserves the resulting
> string, including truncation behavior.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>

Reviewed-by: Shihuang Liu <shlomojune6@gmail.com>
