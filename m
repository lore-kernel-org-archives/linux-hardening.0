Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BC4361979
	for <linux-hardening@vger.kernel.org>; Sun, 11 Oct 2026 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791687479; cv=none; b=iU58e1NGMc/ouOCC1Xt/4P9OnelamgUoWIWoGSaFXtBNt+0nSkRQLNqqKla/ywj5jRiC5kKv7BeU3fzMAtB0jg5fA/RJP/M1QKkUneQWOLKAZ6ij0jTxBM089UmEUH/5ecgM9G2U7rq8xKeB6V9P4G/QSH2Z6Sp/Y4pEMibqEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791687479; c=relaxed/simple;
	bh=sghXvtTDPEzJRg8/9muWYo5VMD1FxRyf/W4rKI9KsFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu5wIJyq3QQqcuC0rGzYofOUulSYB1Grq5/KZhlwsuBUgkXa3c2fzykQIMzFPt5ee1PG4mEycw++WvTDDvRHoLvJApHW/ocYiufewTraKvvBmbvM+hL8nEEnyAUNifRuRH94t6qz3ZRNntZucXES08/5L1/MXOoUn6qJfFemw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSPY+QRy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSPY+QRy"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e8b20a899fso167125ad.1
        for <linux-hardening@vger.kernel.org>; Sat, 10 Oct 2026 19:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791687474; x=1792292274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sghXvtTDPEzJRg8/9muWYo5VMD1FxRyf/W4rKI9KsFU=;
        b=sSPY+QRyw9X5FH5owUepnjoeDJ6iXs7R+esYpOFqh6F1/Pg/1vUYI1qd016sQPIE34
         hyRGpsikP+okyiinphx3LoXI81xyy/HyjooNgrejdF5vT2LdrZyB+kuIXNtRJPrTEHJd
         cW21tHox37a1IZDfeKDuIvizOcvq1vWF2VXEnstFQc1ZUfx+NhGQLNL+EzhEkWH/3+gy
         uX3iVRgbrvWgudfgDkM9PpARwY+xX05W42fJApNAJ0Jlf6vLJopeX+5DmmpRNsgF7klz
         fScTjsibmPbsZ8zqcQUv9SN2lOWJvrBwnqvpb2ucBLwBp21+1OnisWObLhnY3GGqMSEV
         fDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791687474; x=1792292274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sghXvtTDPEzJRg8/9muWYo5VMD1FxRyf/W4rKI9KsFU=;
        b=cHg1n6iEoQnhSSWKiwSORVUrLqAvSqCrBsx9LlidEicbe6xsuRwgUroPIkJfVw6G7e
         NYE8+fyJXCl3VVJ1t/cyfN5bAWzk7Vt5vdT34WDgnN88nzxakwGXC/obRWvwnBnZaHeO
         4WiyftY44iqf74bY1PMg66Rxfx/UyXQ3IFhJSwnSu2jZSIAWQvt+6mXYHOP9ZaASe8PE
         uaxs/tJG+xiaeiT1Xx2uEU67/sMj/eZWPeelyKT8OjQhQObTnkTyOWsCHp5NLBFvawtb
         Bieg3u4l0XV/Egk509vAj31uC7+1iB+AWEFIrnofxL2xJBHoYq4Q/g0hqhCvOtOuf3G4
         Cl2A==
X-Forwarded-Encrypted: i=1; AKwUvBw6kkLLoRkOojsgNoxoL2/K+rux2tdcuRTJFb6FSsNUdZt3v27WvUykCjyz4zYnQmllsRPaDHvaIhx7+PXuJqc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2zzKRTNWuwBngscKY8qxk1/s2XiXWLebZoDG5QXO9Dc1Nmjlo
	VYn6gFoo66pm7051tWWpt/gQ/q8tF02w2gfXYe5Ier5WdlvWOmh7lXrRc0Bz+PZ5
X-Gm-Gg: AYBFou2D66dneoB6xXEiWwCA5N+qx1qWdZKP3Lic55zpVRAFVlJVfhmL7+Voy41dsOp
	4fI8Kp3tEMUeP1FLHs/YDAknt4ktZaCuoQS2DxZADGftOimhIjo9skVeYSzDNZgWDPvpmuSaOCX
	CcWcmS+h998evaSQMF4YrsL/363YdZw3A6hChxhRg5TE6feVg1npRvlPJ4fmv9k83WhzBP6ZIZq
	B9QstpGQCObpD4h82HtB/MZTOzCKh5EsKGy9RR0Lp35y+jKQRTvbdS7PWJb/GmQyi7VUOOAa5S2
	e3qvCdBg21FAah5boDHl15tNxqHF9LMfeHeyDr/pBH+zH3Vld4MEO2q7RxN7SiuW1E56T3mWeYR
	VUlJmrqSbyPmcEdRMaeeCOdN0FXFQiCmKaQD1x2g+Z++q+uzqit69AQzhQfo9rQm1K0ngKv3t/7
	hAKyBxzXLuxaUMbESq1wcobZjsqGNkZbre0tuxVH8DsXiYaUS+hE6O8P+ubu523Uy8Ry989Cmrm
	LvEkSpFOQl3
X-Received: by 2002:a17:90b:4fcd:b0:3a8:6b84:234e with SMTP id 98e67ed59e1d1-3ab3a7467a1mr4832096a91.28.1791687474219;
        Sat, 10 Oct 2026 19:57:54 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45a:16c8::245:79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab39392e9bsm6403592a91.2.2026.10.10.19.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 19:57:53 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>,
	Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
Subject: Re: [PATCH] landlock: Drop __counted_by from landlock_domain.layers
Date: Sun, 11 Oct 2026 09:57:48 +0700
Message-ID: <20261011025748.8853-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010184640.GA40038@ax162>
References: <20261010184640.GA40038@ax162>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Nathan, Alex,

Thanks for the pointers. I wasn't aware of the earlier thread, so please
disregard my patch in favor of the one from Qualcomm and the Clang
version gating of __counted_by.

To answer Alex's question: I only tested with Clang 22.1.8 (Debian
22.1.8-1~deb13u4, same as the syzbot build). I did not try Clang 23 or
later, so I can't say whether it is fixed there.

Thanks,
Nguyen
