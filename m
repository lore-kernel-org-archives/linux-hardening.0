Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC1130A69
	for <linux-hardening@vger.kernel.org>; Fri, 24 May 2024 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564044; cv=none; b=rT5RSy4KtodvTAUQ77Fk8h5DYdNzBKO1gmTN58IJEHcmuoknsxENtLKtTQ7eusRJQ4zOW/Kn9g3GHVA1jv9/NRct4Q1TKPGkpyIQT5XRo5WkAWakyHU7MLwioCOdfAB7fgPx7kz1TaWWGGQ5cDJJV9akhdf9TI9dC+hs8MdvEr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564044; c=relaxed/simple;
	bh=RV6GVQYfwTsyL7UPNTTHnloYfII7Z62+QtP4agNDYW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nt4USJQH/DjeCdPeCbhza0y2vj5kANIkP75QMo/E8xZZy0I5/QhRTJo3Bv4x3cCrdWhyM2PpkV31Ycn/9/xMfPizmhC3ffPbEVYUfLm6q8DYYkMysCim9ifqnGyVrJZdaoWceDUauXzrpfEx2lmcDWILNiAZ3GmTVi18pepBg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gm/z3rro; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gm/z3rro"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e538a264e0so124390971fa.1
        for <linux-hardening@vger.kernel.org>; Fri, 24 May 2024 08:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716564041; x=1717168841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ANScwS6KgdmEu/PK27HSIOzuKwtA30ga/nb++C3vkQ8=;
        b=gm/z3rroAdYYbHAuNd9vy9Lm+Vsg+FbQje+TnxIByyBRepO5BDVrtdxERpNt5TPYZo
         hOfGP+J0G1DTJVuGrJfI7Qtk4lE1MqT3sZkzffcTH3SfGhn4QNGvRbS0cSfittQ3Vd0h
         gFHeeqifVBKS6DyEW0XokeDUGYy1Xtna/v6Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716564041; x=1717168841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANScwS6KgdmEu/PK27HSIOzuKwtA30ga/nb++C3vkQ8=;
        b=pnz9HAi7hE6E7IYkFXlSnEcrO+zKeeYDwaO9LRS60B8xUr7RbfQe6/tDRZfhdPY8bm
         A6OI3p3I3ymzz0zXU6aUOJwF1XOsKgMn3ZvOI5/I+EQpjbUr2hYahx9m6gbUOCjvRfu+
         T3QmUy9zvGZft3bAIsDwTn7yW0kdTRsnX+Irdh8f8kSr7N+oysHvvFYuuqnpZvHxdgXB
         ygOqr6tlNUnIlPTH6qiRx4ESGhpjE8uWZ3Etcx6tF06t+LE9qOK4HfuwmCed8hcJNZOW
         2mmwpwNBoJ3Toq8WtHhTfWne5Y56LXqkyqV3/DoQDFxJw0LPy35anFhR0du8w9ePKWm2
         /NFg==
X-Forwarded-Encrypted: i=1; AJvYcCWaHzyq9YmjQoICeApiQle+Frx0uwRtI8kV1eJUGh0NN6ynGzpy+85oMQgyRgzfxCTMnC4s0ZHW8a84hjwmlWXFeyi04TzszIagrQXcDJIV
X-Gm-Message-State: AOJu0YysMoGC9GUEB0pwt5EsPu9DpP599sR1ohrU0XaASmgh3Z7HDanB
	VbSToDtX0KwGlko7jdnOwzh31fX4JKjvBFSUww+9FYuqLutPhKFpNBC/RfPDtgxNfvlS2VSMbpG
	F/QgrDg==
X-Google-Smtp-Source: AGHT+IEWe542VUXm/bPhuW0MlVRkUuc2y9eyM6vFjR029FnBJq1sXrliNpZqcWCPK4vwS/GVRdF9QQ==
X-Received: by 2002:a2e:900a:0:b0:2dd:d3a0:e096 with SMTP id 38308e7fff4ca-2e95b0c5833mr24956391fa.31.1716564041193;
        Fri, 24 May 2024 08:20:41 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bdd1589sm2335091fa.74.2024.05.24.08.20.40
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 08:20:40 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5295d509178so1059654e87.1
        for <linux-hardening@vger.kernel.org>; Fri, 24 May 2024 08:20:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlgMhpRu/c/AR8/lWS+pi3KonGWWXXZRG3ZcCYVsIF9vLJx9O4sigeEXeP6qPzNP6nvcvHcfxcnYsbRnXjoBPKEKB40SQhqG26/Z/vxGbG
X-Received: by 2002:a17:907:bd1:b0:a5a:893a:a73a with SMTP id
 a640c23a62f3a-a62641c2e68mr221556166b.10.1716564019461; Fri, 24 May 2024
 08:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <202405141251.8E9580E@keescook> <202405231628.BBBB9787F@keescook> <20240523165418.242555ffc2372e59f88cabbf@linux-foundation.org>
In-Reply-To: <20240523165418.242555ffc2372e59f88cabbf@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 May 2024 08:19:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKNsQck3eGc37Da7hAKDNL6S9viwV8ir8BFTu7dsig6g@mail.gmail.com>
Message-ID: <CAHk-=wiKNsQck3eGc37Da7hAKDNL6S9viwV8ir8BFTu7dsig6g@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, jeffxu@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	usama.anjum@collabora.com, corbet@lwn.net, Liam.Howlett@oracle.com, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 May 2024 at 16:54, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> The testing and implementation review seem OK.  But from a higher-level
> perspective Linus doesn't seem to be on board(?).

Oh, I'm fine with mseal.

I wasn't fine with the insane "m*() system calls should be atomic"
discussion where Theo was just making shit up. I honestly don't think
mseal() needs it either.

               Linus
