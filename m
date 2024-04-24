Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CA716EC1E
	for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002943; cv=none; b=Xglug4DreQI4AIm6kVTN+YVfZvcmOykqNnGugvv3h1NnVDJDAoF7rCyLCFpBzMwF3V9IttrENw9Zm2+JmhuzvjTdBCEqaw2xQpmeM+lO/izLWcbEKW/jwQUj7ngZu/vWsxOQ1RzxcYdHXAwRQ4nWe5RajfbcTWxur2kmqjwA0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002943; c=relaxed/simple;
	bh=2/Hfa/dcWjkxZew9ys7tmCgP1thDGraOO4tncLETr3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdQred5xI1R/YG7FPxngS6R3BHOzzZOzustZscGhU3B3O+dv2DdoC+YjM+N3UxOVsPudEE1M9egCA4Lo+/0YP8dRgk0L8wlGefSDCvvoIF+PGyGbqnGmAb/oZcSLWq0FEZCZdCtZ3ui7SmGGR7jj00A1y9X3QIM75QYoiDtHd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WeyPt2Gv; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WeyPt2Gv"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2351c03438cso216194fac.2
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 16:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714002941; x=1714607741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk1vBtrkPJtfbNkGtrMy2gilqU9fSeCuVJ9F0az9iBg=;
        b=WeyPt2Gv565dYBLzpmykhuB92ZbEINflIqMiaqPhWirBf4MQjRHShLrIKCx+9FK9Ds
         ErBWdZPVsARWyBt1ROfTrzNWEyOLCk0qQmfa3YoQYLMZONgL6AfR7CpuIm9XczaMn9P9
         EpxeSIhGdAyiGbWH5m1Z6x6CKbXjYkDKlvLZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714002941; x=1714607741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kk1vBtrkPJtfbNkGtrMy2gilqU9fSeCuVJ9F0az9iBg=;
        b=Rf6Uttbj2DlJT7xT3SWiihD7Neh7A8J8Mrn9RZPGtAALEjtabrCtXStALs8GG4dwdg
         t7xQsPGFXx2PJZbtXqYxzJQtAsuSsPbAsjtP/87p0Hx1IR/GuTJ49EtZZ+gYkehXDMVi
         FrWFbFwcAwIOAcz1ZPc3N9Kw4wlJMmRI/KhLODJdF2Z6/0i7xFTtYxpd5Hm0+t7k2TuE
         Lb/7Gk3ZxwXJypf5bOxa0JyimIP3f1QUPgblpVThXQV9HP3XhzyOEaBre6Xpfg7yCrNk
         XL5VGA+FB/N3l8r1j08b9AiHzOq/2XjTMUTFCYfoxCuZCbp/gu70+v/EGzKneerDeGk3
         COBA==
X-Forwarded-Encrypted: i=1; AJvYcCWh10hZlxfKjrg7F1YVEp8u0XFJRj6IHFSzCvgHcInII+6lVRJGNUaShObi+7XREZ3sO4qkrjUkbUNQvqyUZk3GQxRmKF33E5bowEH+hDMQ
X-Gm-Message-State: AOJu0YxlewaTITAMbrY7EoQP7DxmaEC802d8Bl5N8By+WVi+9JtPBk1J
	T2G0GyXScwS/Mi9gqHLCKEtvYLV2ClWyOPSTA10nNjr5It8cScZjLYaq9676vA==
X-Google-Smtp-Source: AGHT+IG98QMINTQzk0343aGIq+ANc+btBeXk8kVIqd9NLh5j28mHEFdPtL+/Va4lYd4ERDEzyibkTg==
X-Received: by 2002:a05:6870:a686:b0:23b:1dd5:3df7 with SMTP id i6-20020a056870a68600b0023b1dd53df7mr2924743oam.47.1714002941396;
        Wed, 24 Apr 2024 16:55:41 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fx25-20020a056a00821900b006e6c88d7690sm11952827pfb.160.2024.04.24.16.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:55:40 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] hfsplus: refactor copy_name to not use strncpy
Date: Wed, 24 Apr 2024 16:55:38 -0700
Message-Id: <171400293647.3284001.3215911382372065308.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401-strncpy-fs-hfsplus-xattr-c-v2-1-6e089999355e@google.com>
References: <20240401-strncpy-fs-hfsplus-xattr-c-v2-1-6e089999355e@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 01 Apr 2024 18:10:48 +0000, Justin Stitt wrote:
> strncpy() is deprecated with NUL-terminated destination strings [1].
> 
> The copy_name() method does a lot of manual buffer manipulation to
> eventually arrive with its desired string. If we don't know the
> namespace this attr has or belongs to we want to prepend "osx." to our
> final string. Following this, we're copying xattr_name and doing a
> bizarre manual NUL-byte assignment with a memset where n=1.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] hfsplus: refactor copy_name to not use strncpy
      https://git.kernel.org/kees/c/628a89b6ef79

Take care,

-- 
Kees Cook

