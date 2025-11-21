Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5DB747F
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751702; cv=none; b=XPIss8M3DANLRY+e6pGvI/c8MLCFFAMe0TFQD820ilhZiILcTzYw3OI5d+dQ2AoCoUGGpC1tfTPdfeFh8YSFQW7n6AvY2vB2d7N6mHOJSAmP6UdS0TkLXerF2Zog5HvwmWR9hUMl4KkoSk6qxO/8OROfruoRP7i5cADWiOcjHTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751702; c=relaxed/simple;
	bh=znNrGtLO/y2KIKC6w6UbPHjCgvfwhBb8OCIlLO/42vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDXQ0KjKSaMVGgOhQP7lhGFMp3bAPOeRHEB44eqBj0Z1PKosZ0LdmV9xH1Ykku8446KUg2nUYxSm4ytaIsxFu04gdJffbUAsZNdpcghcrpkdqQXBk0K1+L6sbAQEqleWMYz3vFC1ZL6+yGk1j4fth8xjwvteswZJ0rZxWxvXpWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R66xKcqQ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R66xKcqQ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b9da0ae5763so292210a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 11:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763751700; x=1764356500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMRrQ5UDUuelFdTKPrDDsaVzS+ehlFeWjYLK9O4YUmY=;
        b=R66xKcqQ02lkyymRFnl1rGiQ2xkD981v28fgZ3OiB6Zt9qnHZnS2dMI5NKgfaTyyKN
         fx0YDPzQAGtJVHl+pMDj0TU1L5QQZeIQbLz73fymRiwfEfcEXEW4qIoYsM1UTVAzQ2Kh
         980wSSu0RStPflVFBzgdZbWjunA1c3g1QNqtaG9GvmBIKBrbXGfMmzdJ04belCIRLL7L
         CfreugdCMgIygMyuGiLINXpDD6CIfFqhKj0GFeV8ysaUjRozURESk3xD6KwWXJZ3MzHP
         nOSJTbZ2H8TA2gbfzzRIU7XOLlam/cYwvuhGa7nqoyXYKcRVaGAoDvvSCiCS4WcrzyvI
         Q87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751700; x=1764356500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gMRrQ5UDUuelFdTKPrDDsaVzS+ehlFeWjYLK9O4YUmY=;
        b=H8lKNsmwRfMLloWYMmEa6VdYz4NHAQtcCIvPX+rXcfQn+vOrrPz1he0IcsPtQuOM/X
         S+DvWQ3nEVWq0/swQg746pwuQSTd3uNIuH68szgFd+yRHMaZK/5727lKAGhbsPKLI/6A
         OXUlApnqFYQTTlkWZbzk+487z5N55EeZ7OJUdKKEyZOOdGvjxOJN/BpcmfeZQEV9LOP8
         cUmtm5pWYiEklBdwfvtk0NvaEMVXprvBN2EQPQCZUaSKdkFD5T/tMKVLNaewHxp9ssqZ
         QwatoB2YfPRX/RKSTGJj3KpZDOMmAPaxJwLC1yRHdot7eIRhsBx9yIZq47eUWlvnnSak
         ibCw==
X-Forwarded-Encrypted: i=1; AJvYcCXGYRuED9PMpTBPNY08h+/r7O2biBp+oS1qFiq1/eBXEKLvXaQYmIYGRc19Pu+DYKxV4xswDGw5pA3GXAI0o5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/QCv+tA4ECjFsOeWraInmC6/GUzoS+tytSnIWiZOA9ocyzew
	XFaDVHjTyZiqbC6H1pBqZJRFi6tjR/Tfr1wSFpTelhWbOqV8OXv2pRwKrwuWnkNlJ4Ayw4LNiF0
	f/xZyQ7zZMLobn8Rm1qxcWtlyI5ci1qlCXk0/
X-Gm-Gg: ASbGncumdSJPvy5epZebR1IX3GUC4n3EZd6/faRTvj8/PPtAvQPk6l+nnt/RrlyYmJ8
	GvjmwnPqL+Ed9xL19yh4GMBXjf6nnIElwlC1MtoXZ6umRaIntCfrAIjadN6AdfX162AJ9URTrD6
	M0/XtNIuVSEuLs5O1gV06HI/OHGO1xgxx5Ubpu5zA9YWlU0vN4tj8AwTXEpZLAHKtL88XvYF0Kl
	SBHGWjQwY5ZmnTw1X7du8+wAsQ/ZG8a4hLAqFldFG14vSe1fqezeT/PxdmuxFwAnMMbgot9Tvkg
	JMrPYWzvTk1OaUTIWDMnYGWcdKwxzAkUQ1jLeEde1Mm6xsb/liV3BVWKt7PNVKOgt+R+FVJM0O2
	mGp+bs7mzTDKMvA==
X-Google-Smtp-Source: AGHT+IHxzbdxx7SbQCrTEvxngdIKbtJYdfkpcAfmpDXK7Tu1gbYmvuvSxOavC3Q8fiaJxbZ3HHu3Yl70yC4dL2qOhV0=
X-Received: by 2002:a05:693c:2a0c:b0:2a4:3593:5fc8 with SMTP id
 5a478bee46e88-2a719277278mr918984eec.2.1763751699943; Fri, 21 Nov 2025
 11:01:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121184342.it.626-kees@kernel.org>
In-Reply-To: <20251121184342.it.626-kees@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Nov 2025 20:01:27 +0100
X-Gm-Features: AWmQ_blNjwG2ZHIL75QpaofqEmG2atnGSXOJBOn15FdezxxUNWzQjNXhbF1nmK8
Message-ID: <CANiq72mzu_reg+A7vV9ARtu40g4R2rGr6ort5SgjX2Wozo6j-Q@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Enable GCC diagnostic context for
 value-tracking warnings
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Masahiro Yamada <masahiroy@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Tamir Duberstein <tamird@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 7:43=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Fixes based on this work have already
> been landing, e.g.:
>
>   4a6f18f28627 ("net/mlx4_core: Avoid impossible mlx4_db_alloc() order va=
lue")
>   8a39f1c870e9 ("ovl: Check for NULL d_inode() in ovl_dentry_upper()")
>   e5f7e4e0a445 ("drm/amdgpu/atom: Work around vbios NULL offset false pos=
itive")

Thanks for the references & extra context!

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
