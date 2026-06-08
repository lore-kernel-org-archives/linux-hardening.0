Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14A33F374
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929270; cv=none; b=liRvfiELZvcdlGWNhFKzL7BsXMKxvT8ZEnu/eTK1zUw7qLQSBvIPdfvJ2SiHj4lwO/lovvc//sT03EnZjQwkFziGMYojpsiLEmmsIL154WYILbqFLOVpBoGj4gq0UUtKwYQhWX91q0vV7HliKoKfDCQLJkvoBbSMLQHd4IPmT5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929270; c=relaxed/simple;
	bh=2DiM6PFrPZzoOX3Txr45CahtPR9yAKKQFjvEf1Rg/0o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EWikDhB7iZ/ZGdG2l+OqWlUfOnO+PAipU/ZwSc9b97Co1WPeTMc86ZaKjEvDDEtQ3LqKPtVu+Xm0doSpmmq2F4JVLHS31HEq045qXGOf5F7HAKBWbZYWfrro8F/mDuwVJDKxbqrw6VGpxGw9Zfk0yLYLAgOFQZVROxxHAW3MRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=l/HTe1ie; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="l/HTe1ie"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-69e66e11386so1393014eaf.3
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780929268; x=1781534068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/M/vbl7ihKt4hB2QPk1iXol4u8SiMgbyxK1Z7CwC08=;
        b=l/HTe1ie4YJiYPZOuEE26ccKoBxrF8bdcepOCEQo4CE1xjTujvlVGJUf+BzxJ9XoDl
         YHGQLFzgOvkitqdfccA1jDm5ypp6ahRXT7yOXavHPPLp6CrN0HaM03vA9ezuLc8wMTv7
         9lqfHgbl7qpupJhLfuCHpQRAlaeqt9zCOfsxo79n3hcNvGA+28PDuY3DY790IZ6Qjgok
         Uz5zeZXPCFGBYxMylz0eQkkwW8ds/7gwX0V3iSrvzmyWXPUW8eGvl97sSzootlyQ1AQE
         9gAiODy8ptUUEU4tb1XENh6IHWCWAXEqPx8KiD8/d3zOxyfUz5Q/q1M6cGL/webkFbJ1
         HD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780929268; x=1781534068;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/M/vbl7ihKt4hB2QPk1iXol4u8SiMgbyxK1Z7CwC08=;
        b=Bx0hJ64FA5EmwUSvhn8OCnIraou2b6LNQdFNDd4LO5DemQWHBumO53RBhQgBMvG5F9
         f25fOxHK7GcW5yNabS02sX1C4BvsgT+k5anAgkAGMapfcjHGkFJ0FSZvwXe4CcNQWnpz
         xmO0eImqjFRbaXcCabTNKlcze5h3rrDnaOQLUj0Z0R5VzGmM/KjXyGXA6kr8nit+6fFC
         JYY19UmEBuZCFBODw7+cM6QhfWD+x+xkEK/3OtpkL/+NhdxiepAZhKNo36/9Fmvt7yM2
         Zsl3/mQtcI+NMm+Dv07tqOKCom0Rs+m6BBZWfoXSDyPxoqIWTP3Qhiiz5nJRp3nCE5hc
         c8NQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BiJKo9IITh2WZT4d/fq432jQRtabAp6xduvC0kkx6ykyZYfNF8G7436sNMG9COg03XCilg22ICWSxCwEVtmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK9uSw/dTnyZaItVzw7MwYtUkgiliTrreVHSoweC00h+lKfj1+
	RYC0VR6gb/lJYgar6Um5gJScBgfiw3X+oTtSvPeyaHg+opj/Pp/gUph+GiIpANOwP6Q=
X-Gm-Gg: Acq92OFxCgvygyYxStSx0Q1cKaiUs2xx/FXy4zx+Gfyc3L3tkhk6euEUjsIb6HJrMEJ
	orHKi2dxNXQtBivcjJLyMGCHY4hCoVzjzYWJiwGSeF0X+urNqURqYq47McjhJYAE1FEPI18PTAp
	ISkpv469aHc58Z/dNEBcLVgYGDhbfFI9hGD24ZF8zdYoWEAUJjUqpsOHEeQMfQIpLINL+aXbZY2
	lW9yz2USIS33QTP+v0HoV5WQ0tViFGv6ue08PcAsuN/E0Fy3iIaDLVT2nqSbIKEW87sRN/rPlgH
	6vHG9k0yv4TKQWQRrMKG+jkQowjtDLcgHulBD1AFAGFwxiJzb+8T9fp9WwKTfbeKFTtmuLLHzpV
	Cy5QdsWF1WQSKfDHRjOFuMLBzj1e3TRNdDWlwX02O5Jwg7JzDzdDOVmWFnShhMd437SFl24AnOQ
	ma6MRIFYakThLBOijPxJdL9oghpY3dOn3HSaHsRFWBi08RY2iE2u4ergSKDQZ89YW3HfukV4h5H
	fydTULJx5AyZ4Q=
X-Received: by 2002:a05:6820:4b8a:b0:69d:521d:a4fc with SMTP id 006d021491bc7-69e68b1b38dmr7672050eaf.8.1780929267965;
        Mon, 08 Jun 2026 07:34:27 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e464050fasm9622409eaf.9.2026.06.08.07.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:34:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
 Arnd Bergmann <arnd@kernel.org>, ceph-devel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 david.laight.linux@gmail.com
Cc: Ilya Dryomov <idryomov@gmail.com>
In-Reply-To: <20260606202744.5113-5-david.laight.linux@gmail.com>
References: <20260606202744.5113-5-david.laight.linux@gmail.com>
Subject: Re: [PATCH next] drivers/block/rbd: Use strscpy() to copy strings
 into arrays
Message-Id: <178092926613.1038952.2298978254798273245.b4-ty@b4>
Date: Mon, 08 Jun 2026 08:34:26 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 06 Jun 2026 21:27:44 +0100, david.laight.linux@gmail.com wrote:
> Replacing strcpy() with strscpy() ensures than overflow of the target
> buffer cannot happen.

Applied, thanks!

[1/1] drivers/block/rbd: Use strscpy() to copy strings into arrays
      commit: 5ef1b0194b382fafe5023b5b014e4db3b948ee15

Best regards,
-- 
Jens Axboe



