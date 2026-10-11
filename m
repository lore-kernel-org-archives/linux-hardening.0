Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19133B970
	for <linux-hardening@vger.kernel.org>; Sun, 11 Oct 2026 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734387; cv=none; b=uulrjTkOMnwwiLRpX+ii5dbR0scekIrp6BFd93XTH/JWyJwIBOOfOmaVjokEE/YAcughHPBwG6Wg91yiwANNWdvqqchIkK//ZLrpajKgOJH/M+gwkVOHREQvjgU3X4S29E9b1zmlze4Ac36meRNR9XSqPErIeL09e3hnoSNboqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734387; c=relaxed/simple;
	bh=tc916MmcKzeiSk4IxVqtEZOAPg8oprGZK7KktYFCscg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnzNs0bfK6KTgXgc932FlEHJq1KqbeFssAozF9IFBjFTRYw2mYS3WZAj4cXlGiJ6VUgjBD/DaKQy3629jxMA8fg++DRCyCOFoUs5r72VRzF9CQsL3YW4dc7imD42jhMCBiBG1XxKU+GFJb3tDK9va2oCss8WhbykkNl0djCrF8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQW6UiPV; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQW6UiPV"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53440816851so13884861cf.0
        for <linux-hardening@vger.kernel.org>; Sun, 11 Oct 2026 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791734384; x=1792339184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tc916MmcKzeiSk4IxVqtEZOAPg8oprGZK7KktYFCscg=;
        b=QQW6UiPViQNiaVVI9bcr9Px9P08cEiKfxJSWdVrBMFS3VX4u9KW2iGIFzt4MDJKz4i
         t6aecBD++TMJW6V6X3G4n2yJD8eSGXDoq4cTkBPLlMwvlupO2dG0pyhvq944kPIu6M/E
         WnRB3VQu6UURGkTvGQF2NM1q1fjiQXulSMf+0AQxEYfOwuSdILooD2RQ2zfaoUWrrL38
         WUj6VE5FKmBZ9ZcbfoLNpYGPCO8AmrgxZ7ZplJmwuMb7BqHWItd5/uTK3ZZETJS19MyE
         +zYuJwj/Kngsnj4Wl54NMUd5budJ/m4jji1H1k20FPEREA2uFHQtO6KIyL7LR77qyTqH
         qIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791734384; x=1792339184;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tc916MmcKzeiSk4IxVqtEZOAPg8oprGZK7KktYFCscg=;
        b=A4xzuzr75j1tnOXm1FsIdx2NGFiYWTGH4Hck2BrzUgUol/3cwljqzrOqnmFb2GBNZW
         q5MeoVTR9yCOiL54n7jYNb6QH5q0OydNNPuHJnShkG68vwlJ4Do2eFVc/W++KHa6yNgH
         HPVxL9ppDWKV9oEM0mZ0h7fbA6uYxC51yZ1VxH0+hetfWkS8BVatY2ZMjYO/+npbO2Ci
         Pqr0D7U22kxsqJwqo9L5OT1IZApuOALkX6rWJCMhl/D2OodsP5j0OGNo/ATICFkglv8R
         j58RZmZnLH99a8GCwV0Am8ET83dJOxreflt4lkKp6rRNdiGIiCoGt5IK8lYyO9066MEw
         2c5A==
X-Forwarded-Encrypted: i=1; AKwUvBwbMDLNh3LL3bkxhBMKLCV4FMBqylctC8IlZCWisBDR4c/uYGizFRyLVRJCHOVrWTaYzSsQQC8VHRuSgLDoGyY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsIbcGhliiFsGP0Py0M5/iaNLg/ejXREuUpx9JW4DSMrb0tz29
	2aEkadlHC+YYtBKBivd/obj9zUExXYNigB/N6ez2OSjsqoYGHdY70thx
X-Gm-Gg: AYBFou2ua9K9tGKqPgNsKUqOPLumgTZQ4pXfsyM2CiMz931BpEsvXvX5qPCvpG7k2oJ
	rILeWEI5uKaVxHyhvmSQNZlQZ4wqt74BWWmeRL6atYdFRfSvxhp3Mdus6ky+ZhK/dKIoqipnPdX
	oQ0p0xNAfdU+lVlPVhfWebcYsIfSJGX4uJZsQWywHB3p8lZsldq4DHpcingiAcmSCEEkbj8Ie3H
	YmrYpIC0Rq4Yzvu/eiIKdl1ALGR4/eH2H3s0UCYAzFUPkWBCS9reF+b58KuQMa0T85m0GvU0mvo
	ivqLrVwKxhBlqUpq2yAFJw5g2zY6hC+8vqjuVzp15YH96qjNTVZVbhMWZALtU4N31ufvQnIEoRF
	7Un5mlKjjVKYqwFAKRpUbvv2xDokxjnbodJB9MQ7bQRJPz9s9bDfNx9IJ1hKOsSMyZqwUWeanNZ
	1m6N31g50FXlNUs10Q05XQ2IqAsOgJghgGXIh7BO9+tZNl4lwWcqnHDLTv8lb4lzkG6VmqSoyq
X-Received: by 2002:a05:622a:54c:b0:533:42e0:a1e3 with SMTP id d75a77b69052e-5359fb6fa39mr134548311cf.34.1791734383760;
        Sun, 11 Oct 2026 08:59:43 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45a:2646::3d0:17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7dba11sm59816441cf.26.2026.10.11.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 08:59:42 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: mic@digikod.net
Cc: gnoack3000@gmail.com,
	m@maowtm.org,
	linux-security-module@vger.kernel.org,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
Subject: Re: [PATCH] landlock: Drop __counted_by from landlock_domain.layers
Date: Sun, 11 Oct 2026 22:59:36 +0700
Message-ID: <20261011155936.8033-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011.oe8teu2LahTh@digikod.net>
References: <20261011.oe8teu2LahTh@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël, Günther,

Sounds good, no problem at all. Thanks for the quick review, and
happy for you to take your version for v7.3-rc7.

Thanks,
Thang
