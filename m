Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013F1386D7
	for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025059; cv=none; b=nDDTIi37rXHcNLuw1IiJW0ZSmD8vca6dxnZyvKmVOzVz+7uUOuCBI0aYilfNaYaS7CivRlLB+uNDi2p4fDAzMz8FJ2ek9cmjhDJlHBq6h9ki2+/YsGhgPKWWuV5/4CILIg7i2b26pbNIC2eXG4NSqTmozH4+b+Yp+j17u3zmXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025059; c=relaxed/simple;
	bh=8z8MAvxHKzS+k6fGXC+xO+ybT+hocgzo/7IjzUaDw14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOggmDqr7zPfCUljdei3ozwaca9RpgzvrS1qBdGImcYZTec/8mr68u9NVLuRFjLTWb1/7VYsdzr2/MAyQtzZfhjoDW34j4k9zGTW9l56I2CbfCZGpzCq5sRkm3TyPzV2F1/xlLBxF8VlrAOXXTnS4tg2fjLoDxXXpQBUrJ+diGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y4Oo4t8T; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y4Oo4t8T"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dc816e4affso1122102a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 11:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708025057; x=1708629857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8ArUu1n5mbPGhrI6j3PiZyJhlgxK+hO19Vb/Bon/xw=;
        b=Y4Oo4t8TMtYeuplV6385axfrNhFlHgkFOdC3AgL2lQGG6qwp9MuHf8cmMA2m8bXjc6
         JdE7tqV7US8jzYk69S35ekHa/roIE3EuNPWJmZcIJJQrF4OzJl4t38MazNswwPdvdBz0
         q4RDMJc/5FrDqPl7j1kJeLJPQiNZ8vL14ZCcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708025057; x=1708629857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8ArUu1n5mbPGhrI6j3PiZyJhlgxK+hO19Vb/Bon/xw=;
        b=nSFvWMwiHjviEnKgT6vtaIUOZ9DGJhk4RtHuAQqO51Sol4lWz2DbRRm9mm92vd8TOP
         dWzRgM0xbrd1j/GQnNcICgW4HW3oRdkizHHJiDDDCycTZvt4oclo5KUNs0r/jGo7IENU
         BWwCHtrCbo70VbW0ol1nNf5/cw16LIAyZ6vgelA8Y3YMWEsw5rpihuCuYB1dN89Ni/SQ
         gMehNPj/aDf0GAU8u8mZX6ha2Tus3dEpiCaMP0FfCWHK5lUQ7F0anPejX/HzqjEv3PKg
         6VR/F2JkRu6u9lDfcWuc5Iz8IgzG+ZPnauqIy5cZ84LMjzW+d5xLXrUgal3/lYFXBTuf
         Gl5g==
X-Gm-Message-State: AOJu0YxtJKYkBePKws3VU6WqhwELtlpU0X9R0Jmxh6O7piDiHwqyA28O
	F7geSz+wC4wSyJP4SN1aufJSnb9xcXwyxNznioO+7DWJMbKDS6RzkqNGimbnXw==
X-Google-Smtp-Source: AGHT+IF6MYT83ArqVcfJtGT7UyBafcmI5dHnsXdLc/BkRmSosPteEZbttMXhR0YN9WfbZ/ulisp+ag==
X-Received: by 2002:a17:90a:f193:b0:299:1aa6:f20b with SMTP id bv19-20020a17090af19300b002991aa6f20bmr1715839pjb.21.1708025057053;
        Thu, 15 Feb 2024 11:24:17 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g13-20020a17090ace8d00b00298ca46547fsm1823494pju.36.2024.02.15.11.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:24:16 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org,
	Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH] lib/string_choices: Add str_plural() helper
Date: Thu, 15 Feb 2024 11:23:56 -0800
Message-Id: <170802503450.1193091.12053934932020706660.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214165015.1656-1-michal.wajdeczko@intel.com>
References: <20240214165015.1656-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 14 Feb 2024 17:50:15 +0100, Michal Wajdeczko wrote:
> Add str_plural() helper to replace existing open implementations
> used by many drivers and help improve future user facing messages.

I added some kern-doc just for good measure.

Applied to for-next/hardening, thanks!

[1/1] lib/string_choices: Add str_plural() helper
      https://git.kernel.org/kees/c/bf10745c0053

Take care,

-- 
Kees Cook

