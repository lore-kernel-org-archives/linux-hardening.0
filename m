Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4F6FE20
	for <linux-hardening@vger.kernel.org>; Wed,  8 May 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154189; cv=none; b=hf0zsbJLEtBRhqkRzfettxOsHi9RdBnQGsflCTmu4CiRW3YxeHwt6g7tfMhc108/+iUJEkLpJ1hZThOFRfi6HR9wiHzf30V7dTJ5F4VeWXDFnHcjU0riz2j/M8+KLY66WL8w7F2kGw33NG4GjFXPxjFB1bmvDA0hAz5rwBF7bQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154189; c=relaxed/simple;
	bh=hDeQFtkx2/GZWAyhU45hOXqXPx7AQ4PlzH3dLzTmmhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqVt71+C8Km/lN4vYBrgZbQIleV2GaiimXjNgrXqwtUJ+3Ejy9gtJppYkC4kedI5CmH55qBOkqjM9Io5d6QgFOqpI3gEfrgHxfWD/pY2fciZ0x2gANG3glTr68Ry4sXXbJQx0asLXk01zz8GsqTx3pejMLg0d3qwsTzCb9OJ7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ljWbr07m; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ljWbr07m"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ec41d82b8bso37645645ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154188; x=1715758988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pc1W4eW+IgwZK6Yej3y72PjDL5L1vGMvHneuHzMgAeM=;
        b=ljWbr07mbbzjqy4wB9J3yvLXGCy/PHs2O0wksf0X0GajRo+fKM99p/qaroeUZk+9fY
         8oRKXoBpQyuhio7thDEgSdrpCFDSy3JqOob+/SpVSbyv3SBjJ3NA50kVnLHqcxXVoSze
         V0Nw3ARV/J3bf4O5b/1pImxXRNBRJoO4tcMu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154188; x=1715758988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pc1W4eW+IgwZK6Yej3y72PjDL5L1vGMvHneuHzMgAeM=;
        b=Ev/pwyejZqOJWPjajlg+PJOrPCJ2EmGFlFJs1ZkkBKjKJUfAtVFS746qD+vS59dCsY
         ghcuZVtsZRClhGaSGgqmQ+QF1ttbWLcTQPnwJDh+R3iaHmtJkaR6W+cfOKAoXkGkbpWh
         1ZvRT/oF/uVdzTq8gexA8sItepLSz7aeDWNUrn7ABNSoqu5lZ1jk5C1ylALsksNocWAR
         kJPPrfLAlPE2nDL5gnQ7SBxb1zbC2i+mdT9zl9e9hivrZyBG4oMjHhCd45YqSJlRRRsY
         IWpE5cxyccKXU51r/XhWhmzWcQFyzMX6K/1to+9517pKDjprUdlhIArd8q1qIuc1tBqX
         EuAA==
X-Forwarded-Encrypted: i=1; AJvYcCXeKjCjF4L3exUZlBYwY7600w6B6kZDKMJy7kN0Di9Wkrn7fVecRL0g9tNYrrKavpaIJ9sk0GiXyvmWwPOXbasaor2VMBV8cnRH4XFk9uXB
X-Gm-Message-State: AOJu0YwQLh/KEuGZ2is1XVcha8+WjHgMPifG7llqab+ijWE0Gr9XHKys
	mZ2IWAdNvQFH3isKI1qgCvN1lkLDb2Qx/fely+pQlaxMYAD43eg6RF7KDCClKQ==
X-Google-Smtp-Source: AGHT+IFL32HmWNS8P+8r6e24kOmVtobiXguS0Hhjw9CbOf5gzBCKsq5cz5LfIJAXntccOTEvKcZsUg==
X-Received: by 2002:a17:903:228f:b0:1e8:a63b:d427 with SMTP id d9443c01a7336-1eeb0791c73mr21694205ad.49.1715154187903;
        Wed, 08 May 2024 00:43:07 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d11-20020a170903208b00b001e7b8c21ebesm11156863plc.225.2024.05.08.00.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:07 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alexey Dobriyan <adobriyan@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Sven Eckelmann <sven@narfation.org>,
	Erick Archer <erick.archer@outlook.com>
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] uapi: stddef.h: Provide UAPI macros for __counted_by_{le, be}
Date: Wed,  8 May 2024 00:43:04 -0700
Message-Id: <171515418204.39234.18138383965654677988.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <AS8PR02MB72372E45071E8821C07236F78BE42@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB72372E45071E8821C07236F78BE42@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 07 May 2024 19:33:18 +0200, Erick Archer wrote:
> This commit can be considered an addition to commit ca7e324e8ad3
> ("compiler_types: add Endianness-dependent __counted_by_{le,be}") [1].
> 
> In the commit referenced above the __counted_by_{le,be}() attributes
> were defined based on platform's endianness with the goal to that the
> structures contain flexible arrays at the end, and the counter for,
> can be annotated with these attributes.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] uapi: stddef.h: Provide UAPI macros for __counted_by_{le, be}
      https://git.kernel.org/kees/c/6d305cbef1aa

Take care,

-- 
Kees Cook

