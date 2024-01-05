Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178CB36098
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jan 2024 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QiA22JfZ"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-595d24ad466so897710eaf.0
        for <linux-hardening@vger.kernel.org>; Fri, 05 Jan 2024 11:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704483472; x=1705088272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysJtfL7xn4mw2/JhRDtFdZIwWQRHRrqhzNonJ4C4q6o=;
        b=QiA22JfZPLskyBiltFkXNu1FJhr9q+96EtiywnsTv2kq5gqfVpg4AMPZ59pFtrb4hG
         Jwa+Ef8i/jLJjrBbd3qsslSbcTNFsIy2KstFnjssJA44L3eKesTI0TAsYDBhxNrwU+F1
         pExjuZPGRgc9cS/b8HjSOaMypOXbCEJ+Q14ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704483472; x=1705088272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysJtfL7xn4mw2/JhRDtFdZIwWQRHRrqhzNonJ4C4q6o=;
        b=qACFmBhxccr6orWRCA8PDdIEYkRsY3lA+X2XrXz4wK9DQsgokfCjYNh+TqAbgOafd0
         V5a4wF9i+kwddbdHzWrG6p84USqeF0RHgSgMPuj0vntCYDomcqeRiJKWC9i4O+HLgPGZ
         Yx0wu0mUDzV5Em+8kYnC6gP50AFZcw/RnrpfhesHsPyQDLDGhqN9LzIBn7XHdzEz2YWd
         IkP1ZEsM49cIWBTyVuHczV+JGaIS47qwoVsK9Hh96Ud3b6BO3jWtUiFewJy4sK5OLmSP
         hXTaYm9iEcTRJDATZxY2R+hNeL+TK1uXBd72vK7STyvrwF1yJHOq6hkPtH2zo+8PRBTU
         MQRQ==
X-Gm-Message-State: AOJu0YxgVQeqLa2T1fFFlMIZDFQ7A/Z5aAAaoBSPu4T56e5DsHUo8LFF
	g1mMoPvwJw5k/AttKs8FedZQM+cXxog3wBZ9aBD+ety6X8TX
X-Google-Smtp-Source: AGHT+IHyJ08At1xbQtvdZtqNHioDPsQ8FF5EAPZvWfoKWTr4xfM1rd0KIRxTNuZ+Ldep8MpXwH14+oALsgE8ne8CIQs=
X-Received: by 2002:a05:6870:c18b:b0:203:fb8c:587f with SMTP id
 h11-20020a056870c18b00b00203fb8c587fmr2814912oad.17.1704483472236; Fri, 05
 Jan 2024 11:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104185138.169307-1-jeffxu@chromium.org> <20240104185138.169307-2-jeffxu@chromium.org>
 <2024010509-pretty-proclaim-78e5@gregkh>
In-Reply-To: <2024010509-pretty-proclaim-78e5@gregkh>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 5 Jan 2024 11:37:41 -0800
Message-ID: <CABi2SkWrZzxob3j6X_e24-dYw8o3-pSJKh2QDqVDJKVOK4cu=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/4] mseal: Wire up mseal syscall
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, torvalds@linux-foundation.org, 
	usama.anjum@collabora.com, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 11:44=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Jan 04, 2024 at 06:51:34PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Wire up mseal syscall for all architectures.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>
> Doesn't this break the build at this point in the patch series?
>
Yes.

> Normally you add the code for the syscall first, and then you wire it
> up.
>
Thanks. Will update in the next version.
-Jeff

> thanks,
>
> greg k-h
