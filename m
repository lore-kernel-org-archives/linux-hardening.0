Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FCCEBF
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jan 2024 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705769157; cv=none; b=aZVkMBDbz2fgSLqlh1v5t4A/WY3d2hoVE8lc2t84gVQdld3imm/Apt3/m1P4Qg5/SHQJii34ufoXoIoaXQKsSLJxLhOPKoQ2TG4zsVf75BDO0xv8eusPqiJiMIL7L7Nq4l+rdhKIpCGZtQ1GRX5+98cTA2cukSrLzgyYT9hyYTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705769157; c=relaxed/simple;
	bh=YB/JxYQ/pIR3ToqU03uuFdu3N6gqG3VeZ/Otmp/LweM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YS2i3PGQ9CagKaErJz5c/udofz2klALe1yCQyBQAlbT0EeGoxq8cth2KOlZiryoCiKOfu0C/mgKDcuMjFvGgCN/GOKQkitk/HFhXzsB89T9QUufOBKQWopPDW2hvkc5DWERcspY55MBAWYEeOoG82uBFuIk6sFerGAt/5FzgTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QCD9WCo4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QCD9WCo4"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so2383871e87.2
        for <linux-hardening@vger.kernel.org>; Sat, 20 Jan 2024 08:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705769153; x=1706373953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lKz6ORL5rgrlrEyJEOMpjmvWzW5nRmmd6FHj6yauGbM=;
        b=QCD9WCo4M45Atdqr7VIPLMODKDgBJ2lKyZRJP+5A+n7vjyCqqPymrG7Gp3VZviMpO8
         J1PctShiGGvVyylJ1KQmfN5AXKeEONPRV8QKgq9dIlXfEJrXaL0eUwEePgtmLsieDPjN
         ezzJFo/uLzfsbGPGeEb263RJ3tzq6q5RcxIAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705769153; x=1706373953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKz6ORL5rgrlrEyJEOMpjmvWzW5nRmmd6FHj6yauGbM=;
        b=dEFfGLjV5gr56G1Ferk2/Ai9tQqJyyU/aBS/h99sOilA6sPspzc7x3N7APn8ACFj9U
         cqqKjDYF537QRdXwLa8uyRWkdZob7/BsJyeSNBvICOEf99Jx0a/9dF0xW3aQkxN0JgYF
         h11DV1fe5BxPsdittdJUxOnqpsIQgF8mQjOQb6FRtZWeSgJYA1sbe/RUL1MWs5S6ULxs
         iR0+mKenTb3jqOzevxAoNbOB+KtojjJGqYDe30sLX9k/1Eiy0CdPk9+SuyaOOnfEcm3t
         qTjfNgs/aGRehYulLi8/X3NO2diK1/VVwuRE0nI5uAoBjxLAQkEtX2BMrllmAmkalybC
         adTg==
X-Gm-Message-State: AOJu0YyauVhB2v35lBcP3Hdb8qJEPLhBPSLXgZMlJXzfdjE4uu/ofeK2
	vXZPF6l+s+kbefKKsUMk+eIrU0znoPKnkAv4PUrt/jfYcqZuD71f02A8SBRY0t1l6EgDUSMxVyr
	TgRXcCA==
X-Google-Smtp-Source: AGHT+IHQ1/7aC3ttb6pVJ9cZAXe2OdboQoEgbIFYhSBt/fMwU3mcEQvFDyjEXFU47EKcItwnF9GL1A==
X-Received: by 2002:ac2:484d:0:b0:50e:b304:de88 with SMTP id 13-20020ac2484d000000b0050eb304de88mr658011lfy.3.1705769153627;
        Sat, 20 Jan 2024 08:45:53 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id b16-20020ac25e90000000b0050e1bfde451sm1384151lfq.123.2024.01.20.08.45.53
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 08:45:53 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd33336b32so24058291fa.0
        for <linux-hardening@vger.kernel.org>; Sat, 20 Jan 2024 08:45:53 -0800 (PST)
X-Received: by 2002:a50:8d56:0:b0:558:d206:3bba with SMTP id
 t22-20020a508d56000000b00558d2063bbamr704311edt.20.1705768827089; Sat, 20 Jan
 2024 08:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
 <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
 <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
 <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com>
 <CAHk-=wiVhHmnXviy1xqStLRozC4ziSugTk=1JOc8ORWd2_0h7g@mail.gmail.com>
 <CABi2SkUTdF6PHrudHTZZ0oWK-oU+T-5+7Eqnei4yCj2fsW2jHg@mail.gmail.com> <78111.1705764224@cvs.openbsd.org>
In-Reply-To: <78111.1705764224@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Jan 2024 08:40:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com>
Message-ID: <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Jeff Xu <jeffxu@chromium.org>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Jan 2024 at 07:23, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> There is an one large difference remainig between mimmutable() and mseal(),
> which is how other system calls behave.
>
> We return EPERM for failures in all the system calls that fail upon
> immutable memory (since Oct 2022).
>
> You are returning EACESS.
>
> Before it is too late, do you want to reconsider that return value, or
> do you have a justification for the choice?

I don't think there's any real reason for the difference.

Jeff - mind changing the EACESS to EPERM, and we'll have something
that is more-or-less compatible between Linux and OpenBSD?

             Linus
