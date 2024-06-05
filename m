Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63623C28;
	Wed,  5 Jun 2024 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717625419; cv=none; b=gnC+zZzoQegk6M3EIbGKY3BlI9scW+W2HC94OToZ4go+YSf0gSbI+3m+UKPvuFlfzPbSokUyZXx6Vo8yYaa/lqltcDYdu+71Jwp9+0+F1WXStxYRYJvqlHrJnidoYTujx0GXYo6GPG0JoCPaMlanuA9F5jGJhNPhiMwtkIWHXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717625419; c=relaxed/simple;
	bh=4MtmmxRMBlxfNJ305JevlhUwnKyFWYAIWelpGhZ8Xhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IcHGz327ehQumCPhd7weSvwd2u7YENYTbEZlVsTpUK21/usbq4qpYHJfER2KC/kyfzz5bhcpTdHkuHfAos3zXF9XYmiU6eZYWZDiZHk8g3Udt4MXrbbGJI410tBD2YRRm1RSL/VC3ZI3BadmpqfUsgFyXVzAfu+C8aDClNtL5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxDr7PEj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxDr7PEj"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f44b594deeso2426525ad.2;
        Wed, 05 Jun 2024 15:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717625417; x=1718230217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJJ1Il1hEBNHAhh0aQyG/BXiplrVKkTrWLDaHYRJumM=;
        b=cxDr7PEj3OWN/Zdcry00kzuKWJ8wXEqwlZx0xDhGVCbVmI8PqGDiHEE/cu3208E2gW
         d+7ZplvkEfeb/sDHGwWhGyh4IGul7B/T73qDUIhragF5drDEYz9BegZWUMgp4doB8cxf
         3csIvs7OzMvUH2Wsyyy0Wx2qKDpnpuAsj3VZ+zXwuWIGNCxESqZLox859DmvczP1ELLU
         dYXInkPVZTw02h3e9sfq6D/rFWYjosvSxX8ee5yrsqvi3+HO86y8cBFYTXHiNXQl+Ho/
         XZWvlyR5vQBYkw1JLBxij38XbD7YCSFMVHCVJorCOSrCdpqbgjF2/ehhcm8WGY7bOTls
         Qpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717625417; x=1718230217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJJ1Il1hEBNHAhh0aQyG/BXiplrVKkTrWLDaHYRJumM=;
        b=FNIwT5KhQI9RdLFwYyvMmjjIRWJNJGc8DKbImdeZ3BJpghR14mEFqECat0p4OMuVR/
         GiQJSj4jEuM01GLuNRRXzIhuWYwZTIzOHEug4vJb0CE+JX/LJEkXmE3XxWJ+vXGLz3qr
         ajzug1Ph0NIr2RozLDh8iwUUcKpncT9v8dmMXfW6adx/9YiVmpoE4QeWkgaZeswmbMBy
         yrKQYfBHEBSmcBblKZ/hchLM9I16DltyJ2zyupmFbATjC/b4hU9GTRnFrXV/pP7fAJjh
         czlk6vaBzoy6PnbnAG0tac7NSIlFiNpIiMrWLUJ1MZBfcBf37eLmuJF/sW2Y8tnrRHXt
         DuCw==
X-Forwarded-Encrypted: i=1; AJvYcCWQh4Sqd455GE5wq7U5GnuRyBqtSKJDToizBkDlZJXS2Lxznk99VPcecbxa4R0lj0tE1PAWIU6b3Cl/ZQn8Ghi9BDYRSQYIT6NclVt83pJR2sUwM5xhhaLk7ptMCzpMXmDrvjR4ljODFPdK8GOq
X-Gm-Message-State: AOJu0YwFLVV6c3Vydw8rTHQBEs83enrICxG7bjfDwNNLmk1kURgeeGJP
	FourESZrwpj1qUQ4b/VSR/OBtbxuaDpj0Yp4p0nOiYgtsYYTkReD
X-Google-Smtp-Source: AGHT+IHRXnPN0u7Ps/6G42PH3KCbpcG6/xDZesLl4G01pVNLBwdTragYtQjUCPK7uxG6hIgrhxC+Qw==
X-Received: by 2002:a17:902:fa4c:b0:1e0:bae4:48f9 with SMTP id d9443c01a7336-1f6a5a13943mr35800775ad.32.1717625417010;
        Wed, 05 Jun 2024 15:10:17 -0700 (PDT)
Received: from dev0.. ([49.43.162.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f14csm374425ad.21.2024.06.05.15.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 15:10:16 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: keescook@chromium.org
Cc: gpiccoli@igalia.com,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	tony.luck@intel.com
Subject: Re: [PATCH] pstore/ram: Replace of_node_put with __free() for automatic cleanup
Date: Wed,  5 Jun 2024 22:10:10 +0000
Message-Id: <20240605221010.22262-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202404241639.3F455ECCD@keescook>
References: <202404241639.3F455ECCD@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Apr 2024, Kees Cook wrote:
> Please don't move variable definitions into the middle of the function
> body. :)

I have moved the parent_node declaration back to the top of the function body.

Patch v2: 
https://lore.kernel.org/all/20240605214944.22113-1-jain.abhinav177@gmail.com/
