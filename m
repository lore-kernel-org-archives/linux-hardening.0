Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F2C651B2
	for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662977; cv=none; b=T3pQwxaVaQz8uFsEg7ytwxMBb6ypIw8hPhQT3FZU7UGYFliu15bf6eNhbl0n/NiEo///4RkO6itrMr3p3ItO2iJmKtjBBRQDlF+3/Ouce4XKbVMU5f7GU5zd5+78HrbzHkRN4VGw3yWnwtHkKcCnAJihixvYy8E8wYUWDUeI6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662977; c=relaxed/simple;
	bh=pGaZr0I0VXtsY65MGDVwpcayT+W78gHjXNkg2BHSWwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJIDovM8MS7dDeqBz5fU0rmrnYmpGq5lQVKe7vaHC/iMZXuQTnzLjRISu0i5qTrcOONJO3n4Uny1AlG8Jk0wb7u0iVkcmgqFPmKRcgjxRbn83VikaqlIFeU+YRfpQfqWXBo6D7lWbU2pBwV8dPuIdo9WVidgAppr0CGxuMVD1Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RamvnTJB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RamvnTJB"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0025ef1efso11131965ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711662975; x=1712267775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utbXcMvoS/4yMiqoNGvBfvTA5qgZ54Dl0x2lTMpmBl8=;
        b=RamvnTJB8z5JMnpA4l7WLycsDmPk8k4VoWG5B7lOBDXt8JCK2p6JaR8KHhMGD/B5YZ
         MnGViXm22W2k4gwQnRiZ7Q+24WKuccf2NK3TTpCMfyxi2QIM+Mb+zXe7TFur0aFIgPd8
         1aSLXneuzDit+gehn/mZpbzcgWOFUjRpPeANI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711662975; x=1712267775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utbXcMvoS/4yMiqoNGvBfvTA5qgZ54Dl0x2lTMpmBl8=;
        b=n8epZmUkHlUDYqqWwdDuoNZCdsHs8Nx3EKxwsZa0hjIcB2CVLIHb36LqppyF5mZwfp
         NDMl7rNHA8Ja00+FAMQ3qPvFLfvZyxnzhoqmBoGHLXo0umGiyJFaZuAASq1nChvqNgPX
         n10NCjfAENEaTcgRyEYF1P+TagwXl7eGILJQIrZhsgfpPOGP1yN5KsbSBhCE+ZDQ/ExW
         0CANIISA5OGyScuaNcBxqEnE6NNqxAUfxvDrda2An9RGlx7nQkRn6a/w8WoJmT+UKDSP
         SomiEPTGs2YoOGAYV7zqQ1TDAVGOraA62N2yMfDotAAeCX7GMSRmFLhwpsqEeo0Y2+Oi
         b3/g==
X-Gm-Message-State: AOJu0YwveBFKy/nbSHHLj421q3NRifg/zcAa86E/q+aTXikHMevztvNm
	vjJP1i6O6Ex8RjwIf6zAZbCO6p5klxyc1fSAoRY5KOnz/6blL7D9LTHKoOjY9w==
X-Google-Smtp-Source: AGHT+IH0vwx4I06MSrNEDlBuzerdk685tCIwfv4qmmnpqnH7QEZOeqH+rWOw3zrbbN180XVtRlKswA==
X-Received: by 2002:a17:902:a388:b0:1dd:b3ef:4528 with SMTP id x8-20020a170902a38800b001ddb3ef4528mr748393pla.52.1711662975100;
        Thu, 28 Mar 2024 14:56:15 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b001e0b5f9fb02sm2156087plk.26.2024.03.28.14.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 14:56:14 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org,
	Ard Biesheuvel <ardb+git@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	kevinloughlin@google.com,
	thomas.lendacky@amd.com,
	Ard Biesheuvel <ardb@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] gcc-plugins/stackleak: Avoid .head.text section
Date: Thu, 28 Mar 2024 14:56:10 -0700
Message-Id: <171166296859.3578759.529846502989874977.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328064256.2358634-2-ardb+git@google.com>
References: <20240328064256.2358634-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 28 Mar 2024 07:42:57 +0100, Ard Biesheuvel wrote:
> The .head.text section carries the startup code that runs with the MMU
> off or with a translation of memory that deviates from the ordinary one.
> So avoid instrumentation with the stackleak plugin, which already avoids
> .init.text and .noinstr.text entirely.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] gcc-plugins/stackleak: Avoid .head.text section
      https://git.kernel.org/kees/c/4ac9a796ada0

Take care,

-- 
Kees Cook

