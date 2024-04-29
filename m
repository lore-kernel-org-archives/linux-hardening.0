Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA4613D29C
	for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420191; cv=none; b=TjRaQJPNsD6ycQ1W1+b+yc4Ob6f6sj40NVvnDO5T096q+xoQc7qLIMeUOJhncZcDCCcAozW5FlGvJN0/I18M/TS+jWsjKimhn6gYp/GsKIyDmhrX9gQ78KVG5C15KY/Ohm8AC/xGgfl0UrGS5gkhQRSXp2ZsJGhTHm9uvau3tnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420191; c=relaxed/simple;
	bh=fLy9wuUj7qj/KLGKoiK5/omRxQbXTc/lSN/3AugUd4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETch7SN8Y8vfo3g4zy4lpVMbxJYOg4FsOy6sdPtc0OGYYyLG+wDaNE1lbQJxNKkuUbOgJhREcUUIY1iNM7CT2LXJw/rHIu8s+eFt0yG2SMyEfplPCF72ydQutjcyB5JLplIkNNdV4vT+Q10ydNjKcKw9XgbButLnSrWUao59oyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hFBGjjrm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hFBGjjrm"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f07de6ab93so4520575b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714420189; x=1715024989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HdmEYuDR/RJEQB35GPv4tDo/+p4YFOvYsLxCcDQQsi4=;
        b=hFBGjjrmupEELOGBImuHMuFkbG6kgsEK4o9GXNq7ILpZ4p6QC3OhT9FOjIhH3+muUE
         RlX5i60LxP0MZuHjW28H2rDZ+d70mD6jbBtAxMwbyI6EFOVz0FiXpeD8MG9cJ5nEwVtj
         qavG754xc3mvGTYUJe2eVq6lSM1H7QAio1xPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420189; x=1715024989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdmEYuDR/RJEQB35GPv4tDo/+p4YFOvYsLxCcDQQsi4=;
        b=saIzz0skCQfJK7y/3AIla6kSdqrdhV9aJFOq5Tp8Sxz3kYgGSqwlmMtsauqg4x+OsB
         PXUdsGGR3zZOpfYheKafCT1BVDQwY9MHbaXhvKTgFIKd4+TjZMaT5PXcNxJudzOcpmu0
         doJbAgrzwZdOoBBbhfixormSJGcCmHkK54ELV5NtFEaOuUbQ8DGN3Nkl9TngcVvM4Q33
         U0LIJ0R193eTnzyZOeOAlCzptYC0xwUD7kvF7lEyqlOp7gGLKCPc4Vh2Z6j8FDGclmLE
         bW0ni0aJF1SxPxSuOLcLMCHareGb4TK1W2L6BsfOQAoC/Z3SN/mk84n+NeSthmQRvrN3
         J5bg==
X-Forwarded-Encrypted: i=1; AJvYcCWYl/znzJ6oi9jwdLdlXWERAUwiygOwhyK8QoY3lZIousKWMrN5NdpmodWseQXoPZooaj70oYau780NfX+SqesMea4p7oSMGcWMbj0HaW5u
X-Gm-Message-State: AOJu0YxiWRSZn71SJKGa01YxcvIUWCaM/KWb0aN5Kg+rN1mMa8KR3LX5
	whlJMOdJT/csA9IA39wmqYO3uyu41c4UWYyO/uFt6EoxUDeyvA9TWTDYgzOVOw==
X-Google-Smtp-Source: AGHT+IHMkhSs/5SnSlE9LvmWTc+i3WLtTxQUmkaAPchto2E1fkXuXDdc1dfuIKTAOn3H+oooC1kLow==
X-Received: by 2002:a05:6a20:9f8b:b0:1a7:7358:f108 with SMTP id mm11-20020a056a209f8b00b001a77358f108mr14742494pzb.24.1714420189565;
        Mon, 29 Apr 2024 12:49:49 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902a3c500b001e8532292a6sm21156271plb.195.2024.04.29.12.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:49:49 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:49:48 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	linux-hardening@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v6] checkpatch: add check for snprintf to scnprintf
Message-ID: <202404291249.078D924@keescook>
References: <20240429-snprintf-checkpatch-v6-1-354c62c88290@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-snprintf-checkpatch-v6-1-354c62c88290@google.com>

On Mon, Apr 29, 2024 at 06:39:28PM +0000, Justin Stitt wrote:
> I am going to quote Lee Jones who has been doing some snprintf ->
> scnprintf refactorings:
> 
> "There is a general misunderstanding amongst engineers that
> {v}snprintf() returns the length of the data *actually* encoded into the
> destination array.  However, as per the C99 standard {v}snprintf()
> really returns the length of the data that *would have been* written if
> there were enough space for it.  This misunderstanding has led to
> buffer-overruns in the past.  It's generally considered safer to use the
> {v}scnprintf() variants in their place (or even sprintf() in simple
> cases).  So let's do that."
> 
> To help prevent new instances of snprintf() from popping up, let's add a
> check to checkpatch.pl.
> 
> Suggested-by: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
