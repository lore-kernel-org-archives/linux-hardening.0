Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0B3C17
	for <linux-hardening@vger.kernel.org>; Fri, 22 Mar 2024 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711078154; cv=none; b=Vt6FyFsuUwriDzOcOFdc6B8jjRiv4jS89R0FJqGSqA3Uc/xz0cl24TgVyEjD/WPWBxCK0UxZMEGuN5tlf5Vi7JkV+zV6bgMG4AqnE+68+0t5Cwdr8oanbH+M0YOgxegA9TQXVJb6COoGsHq7ErkyXa4pa/TbtbFVnTxjJLN/Gos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711078154; c=relaxed/simple;
	bh=qvJ+3YFxfDePmsCIW4PY238+EQenGMVU9ozMZJPSRfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyDvgVuMJpHTGvE6j8SBW5wJ0gbU92BGp1/uPvztDe8jLkiYv/oKefULg3cgUc3qSBvsqJ/Uk2KlCWInZdY4DN8o9i2l2OZUWPo8wPOa2rzw6rITPb+hZE4mD7QIgq6ViZ3qPGP+TIe1055CHnW/dnGngsawiuQUKZghUBTNhw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=anKAke7q; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="anKAke7q"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-789dbd9a6f1so125096885a.1
        for <linux-hardening@vger.kernel.org>; Thu, 21 Mar 2024 20:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711078152; x=1711682952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AV6vFBRCysrecCdTrQzr9r0j273jT0maLCCHGnLq8AA=;
        b=anKAke7qRydw+3gWO7MLJzQb6rvL9vXpiZWaV31fam5jDXr/u3Hz/v5D/J25Hxz/di
         2IwoJbkROU9KOEbMceEJ3f+OVfR5UYCZyA1XdFiuUmu0KrYqi8oKm8YU51cMlUud27TM
         xl1Ze6yu46/8EZdl7CXWPH7qqNJmlM9lcQcPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711078152; x=1711682952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AV6vFBRCysrecCdTrQzr9r0j273jT0maLCCHGnLq8AA=;
        b=pQAyHmvmKjlukMaUS4c4Dn2cL0pgMTjfAMYhgANxrFnCoJZNmmZEvsr/OWAiA74pq/
         0QQyuIqESjxsU1zVEr8oOiMmSuEF3acxG42Crz/hMjXVxEziOufffWBK84fG8/sOxBPP
         MYKsFIQPX7kSUiRdX02HX3DnQuBHrSBda1oICm2+Gb8bOt2Cr5y2B0YATg4o6/mdFT+M
         bPjUm87YXH9sviVxskw4bttvbysIxdAbA39X0HurGi861oAKQqHoWoPDsL7YCkPRhhwu
         LFTQ4cXRIYHX0GJgvboj6A9CcMerLbMtML5QJ0s7x/zNCqf/FS0TsOjJNXf6G9kMoADP
         Imqg==
X-Forwarded-Encrypted: i=1; AJvYcCWJfgxpYYeJIFmmPk3aCGaSpBdMMdHlzj/93O2/f36Er1eKffvZzIh45x942ceQZ8hMyXFo3OH8BI60mwDhHqMvdr/PZ1cLVbKYNW00HsiG
X-Gm-Message-State: AOJu0YyePECqpnxFqkpTjKZDzbLZeoWElwBXKB7SX78brAZ+v658ix+i
	nSOdAbnPM40VG2++lOdilnfvS/UqzLZIe+qbik2Qd1yJ3Hv2DmtiGfmrsZRUxBA5fTXbty63gls
	=
X-Google-Smtp-Source: AGHT+IEys3W9wGHLskR2Zg08t6A2fKR7mvDlrO3Ptg9X+wIwXdgzLVMAbC9r2tAMxNwMcoP2Vea6dQ==
X-Received: by 2002:a05:6a21:9994:b0:1a3:3064:9931 with SMTP id ve20-20020a056a21999400b001a330649931mr1699512pzb.3.1711077791861;
        Thu, 21 Mar 2024 20:23:11 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bb2-20020a170902bc8200b001dd876b46e0sm669300plb.20.2024.03.21.20.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 20:23:11 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] binfmt: replace deprecated strncpy
Date: Thu, 21 Mar 2024 20:23:07 -0700
Message-Id: <171107778560.467582.4496512848388862288.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v2-1-0b6daec6cc56@google.com>
References: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v2-1-0b6daec6cc56@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 21 Mar 2024 20:04:08 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> There is a _nearly_ identical implementation of fill_psinfo present in
> binfmt_elf.c -- except that one uses get_task_comm over strncpy(). Let's
> mirror that in binfmt_elf_fdpic.c
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] binfmt: replace deprecated strncpy
      https://git.kernel.org/kees/c/5248f4097308

Take care,

-- 
Kees Cook

