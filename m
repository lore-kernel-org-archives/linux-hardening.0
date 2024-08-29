Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BA61BAECF
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967294; cv=none; b=VUdYqvLtF5ml1IBRywyfW3+oOKvg+T62/4XGxZknnB7REXaeq1zcJmWBJ6ZCVz0nCmo5v/fHgqvtICGfWNJGMZYKrCIfYtH8n7XaZ+qwOqNRqsw22BPTZhqYsRUKkQinFBaj407wFbcxJh7DkwDHSdeaJEje8LElc8Nzuibpsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967294; c=relaxed/simple;
	bh=bJxYo/loYzTMctQyY3/qVqz2BwxaM68ocLwyaWudvJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKQayp6kaGdv9J+hiLhQ++YgPHFPCCQfLRKUvYawnGRh1LVTcfRfh5ZtRlrBPoAXGEyf/n/Flo1VMmbxZ7unPZVq4dnhmcmtchlKNiuyCGO3I5ab9eiqt2U1Daukr7HRAE9pTqZtt1aTRbZw/ZdxvsIluwbYDEfAKluoNpX2dps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z/sBTx3T; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z/sBTx3T"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2610c095ea1so141621fac.3
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724967292; x=1725572092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JtBxizp2xk+cb6j8tpy+Jh/K4VTYG9aTNZKmyMd4xs=;
        b=Z/sBTx3TF5UZc2P84DpALWNZ9Igzg3JvSIV9b8E/PkUK6Hi9scUHdoNZQ9FzjzIiS4
         3M1bv944aw/sO6YWarRdJq80NYpvXzuiFCatSdC30GQnmsJcp4K9XlBs0MGmgSkSVo7B
         rV5mm8TFWdN+KlD4pQ1umHgeK+lneQleTcYlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967292; x=1725572092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JtBxizp2xk+cb6j8tpy+Jh/K4VTYG9aTNZKmyMd4xs=;
        b=hpq4Xq2mykNrzDYmU2Owl9/3j3qG73yRX0cqZ3Ppqnyza1z7sjTnUpYPXDgQ1kwqvE
         xlvo+hs+qCYZTbpNDFnf7Q05AhBM7cW9BfC1hAAzs14xWYCCQiLnZCUQKIIIQu0xPcwQ
         kkG+216kNo7HI/5ytqKKiVndw4cMf1HUq0RIhKL6wwkc5BpNw6hB/imuXZo9m0jVsUaN
         b0cCJJ8vP/dDA1VN/sB0aJSSqYl9/3PvfE4DDXJMU98TVoZVEeG6HxQD6gOy9gk3eX3U
         /QyyddGawZjHGmtPvLqq2GsW+hsMCrks47UpfPfCD4AKd7yXvBSOBcHH5Emj0l58Y+5X
         Z3VA==
X-Forwarded-Encrypted: i=1; AJvYcCUD5ph3WrPky4aDw4AKSMVMv2JX/TfF0JcJs22x8iYmTXhPu16qXeCGUHRoHMWyrWNXwi2ghbBOg0Omeafqows=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8o7SylpsFECUcfiKdphq+hq4oeiUruPXdFS1eek3ZH4+dTNyZ
	u4gLotnB83IK2+YeZaOPRX5ZROyag5DlXBfKFVjBCy5jIYyAKblwX48Cz/zifXs8j5SRhq7FrF0
	Gm/rMo4b5rQZOtoyflzDG/Pjrm3PLt5925k8A
X-Google-Smtp-Source: AGHT+IF8S+GO7dEufmTmvxbO4vM2RK3AOgSOXWQtC8IWIc2+VslrOR7pjLdfmxtOCWGYxQmolXhTV6/tS12h6+WLD3s=
X-Received: by 2002:a05:6870:c186:b0:268:99df:437c with SMTP id
 586e51a60fabf-2779008e247mr2378244fac.2.1724967292019; Thu, 29 Aug 2024
 14:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <20240828225522.684774-2-jeffxu@chromium.org>
 <CABi2SkW9qEOx1FAcWeBLx_EA8LT2V_U6OS1GmEP433oA6t35pw@mail.gmail.com>
 <097a3458-0126-48e3-ba0d-d7dc7b9069d2@lucifer.local> <CABi2SkVe6Y4xypBw0n8QbqKJgsfy9YRNJWvBZ3bjTa=-Z5Zn2g@mail.gmail.com>
 <5a312d38-4591-47b1-9a6c-4a7242dbe20d@lucifer.local> <CABi2SkXDVgiUeC1StbfggvtiYG_kDxQJsZPpDw-NDPNv6-dwmg@mail.gmail.com>
 <ZtDS3AP9Ejt31EbU@casper.infradead.org>
In-Reply-To: <ZtDS3AP9Ejt31EbU@casper.infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 14:34:40 -0700
Message-ID: <CABi2SkUfKO6ptg8qwWgYMEfmJ2wGpff4kAV25yNPQDFOivVQkg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, pedro.falcato@gmail.com, rientjes@google.com, 
	keescook@chromium.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthew

On Thu, Aug 29, 2024 at 12:58=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
> > > > > Can you send this as a separate patch, preferably as an RFC so we=
 can
> > > > > ensure that we all agree on how mseal() should behave?
> > > > >
> > It is not an RFC because it doesn't change any semanic to mseal. The
> > updated test will pass on linux main as well as 6.10. The increased
> > coverage will help to prevent future regression, i.e. during
> > refactoring.
>
> You seem to not understand that there is disagreement on the semantics
> of mseal().  I mean, ther's been a lot of arguing about that over the
> last week.  There's understanable reluctance to accept a large pile of
> tests saying "this just ensures that mseal behaves the way I think it
> should", when there is substantial disagreement that the way you think
> it should behave is in fact the way it should behave.  Be prepared to
> argue for each semantic that you think it should have.
>
If this is about in-loop discussion, this patch also passes the latest
mm-unstable branch which has in-loop change (pending Liam's fix on
mmap). The increased test coverage also helps to ensure the in-loop
change's correctness on sealing.

I'm not aware there are other semantic changes on mseal, we can
continue this discussion on V2 patch, if necessary.

Thanks
-Jeff
