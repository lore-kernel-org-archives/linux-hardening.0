Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947B3803F8
	for <linux-hardening@vger.kernel.org>; Wed, 15 Apr 2026 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278337; cv=none; b=FuBRUb1sMz+93ZeNOgrDsoQW5+HhNqqnGBwnvAdovS2RyeVElNA6Bzd5Acw5pECohF84gh9K4uTVtS7KM+dwiplRqSFufsTBbyXAPIahO51F/qxuomxPYDb1zGj7hTG5p7Nx1UHDFGRt0rI/r/2ufJrNycjeBrAGWhCqbxATe4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278337; c=relaxed/simple;
	bh=6VzPvjn6SlsaPNHRPPpez6ncx8IwPQo3kOQ6NYhJvSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSk+4kSWFUfNLM16xN0AlqHs81N1horLj+uI1RawQIOcFgV5+EfQQ1n6On8sffEnND2vg1ci7hXhryHYXnitJWukE1O30iWJG6BDwZPINNGVcvizjfEYjmq5Z1nAj42RRulpXTBnO3xSmLOKgRAGa+PtPfjKS/tMiiF7zzIHkVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maUZSdRP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maUZSdRP"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso110030545e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 15 Apr 2026 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278335; x=1776883135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqlBBTCIOKsamPbXZbMcmO0lTLqgGDxSRYX2crrZHzI=;
        b=maUZSdRPQI4B/DkFX9jS9TtUByS5aC607qgDMON1JCScHu1nmMe43f3n4nJKpUgQx3
         TElN7DNpuRrl38wpKFXGmype9VqHXKe8kGNRMy6XGRU3I/qSbxUCXthZJybit03O2sYE
         MTU+f7KoUqKPCT3ebiSFeYyH2W3xbx8KsctaJ9I1OxMnH55S5E6be0NH3kBnphq1wQkY
         r3o1DC24YydEx9oDwkOR6YpBmDzdSbCj7LMElt4DT0jflD2j7JLVwCu9mATke9ioOQ4l
         BoDZnd02iX93cLg0l7I3+qb1L8m0bhGx+hsaMNnDFXA2oNIIJcdh9rgVwCuOFGwUT8yM
         Ci0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278335; x=1776883135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dqlBBTCIOKsamPbXZbMcmO0lTLqgGDxSRYX2crrZHzI=;
        b=b808ZD2NMmIyPLkW23zTSYYfsWKO/HWHL+QTMSgHdjbpS3E+6xURegDUbugAhFLV3C
         YqHbNi6YSUei0r5RJDzWnTbYaK7AEYRLwmqUx7C8OGMERc/FKG2hiPK6Bzpc0eQ5/vXu
         hAR9Gbp9tul6Qx602xvQmaIHOIw8HUFXzLPryZSLfAxXQ3QCDYZC0Ux2RJmSGzaF+vPD
         WoWWlIODRE4um55Rl/R63eirlfKyFaHpmP9Bnj7hX9S08aF1fygz52cH+vjBrx8oUdAG
         PyPEiTgQZp0hzjj4xMfA7WHy8M9hvgeBZMjNl8eUvcmbLr813/dIxTqxaXe/X3ic2qAF
         ESPw==
X-Forwarded-Encrypted: i=1; AFNElJ/S/5es2ZERNy4mESt2JfJ0WRXqtTlrTUq/XDfaB1zsbG6vOPaSVxbV6qCPE5M3EXOuQ9RTA30dEGMfxHJBxho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7ZQcFlX0/xN49cboCHHU8yj0VWgBRV63vbhkLvUV8hbjW3N/
	9sjosNt+Oreq9EGWCvUMGG5/Herlui4ypZEwVpfgRKOs4VvbGzJLpREze1tkGowG
X-Gm-Gg: AeBDiesx/aclpJeCf+FdEmFT8/+qxdwsoPpk+vKWUlPPga4d+vD1ubnAINjaxRGb/qH
	9TM3XB977EXAmNMo21+pXJzPknUBd/QzsvzHQNSLLGjq27nVDnRkwEjUwFo0TvG8/obCTEURGmB
	4c3K5XO1FMD9Hk8HioR1GOA2FICqh2bDQA1TMRtPSSiLEtBZ6B4GGOVEMp3iRL7ep+0k4n4+NhN
	scHvePbkI1xpbuyiwmo39rmd/YLpi10wPkkKjHs5A1oofbTnmmwhJKBlARa+zVUI+vscr0yh1BT
	ExBbonHh3yJNL5CqjW/DJ23emJMmQqMgTTbv3I69xzmvYBP/JhycGVzD+ElYKr+nHZE99IVqr2w
	MmKaaDJQVnvDUurjMyjTirdJ6/NVQFqT1XM6qqZKDQ4Kyn8yITnYvbekiRjaUBcE9FjBwvDsoYW
	9VfCyC+KhZo/xYqq4hBbp2KlrASYuLgpSYlp5xTYnAVSse4fJoT+2YoFUh3lCnYmOA
X-Received: by 2002:a05:6000:186a:b0:43d:77c6:be78 with SMTP id ffacd0b85a97d-43d77c6c462mr21260031f8f.39.1776278334509;
        Wed, 15 Apr 2026 11:38:54 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead401ca0sm6144220f8f.36.2026.04.15.11.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:38:54 -0700 (PDT)
Date: Wed, 15 Apr 2026 19:38:52 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, Andy Shevchenko
 <andy@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/string_helpers: drop redundant allocation in
 kasprintf_strarray
Message-ID: <20260415193852.3171301b@pumpkin>
In-Reply-To: <ad-j4eGpltrb-WQj@ashevche-desk.local>
References: <20260415122542.370926-4-thorsten.blum@linux.dev>
	<ad-j4eGpltrb-WQj@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 17:42:41 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 15, 2026 at 02:25:43PM +0200, Thorsten Blum wrote:
> > kasprintf_strarray() returns an array of N strings and kfree_strarray()
> > also frees N entries.  However, kasprintf_strarray() currently allocates
> > N+1 char pointers.  Allocate exactly N pointers instead of N+1.
> > 
> > Also update the kernel-doc for @n.  
> 
> Have you checked all current users that they do not rely on the NULL terminated
> array?
> 
> Note, that was done on purpose that once allocated it can allow user
> to drop the track of the number of strings and rely on NULL terminator.
> I.o.w.  the number of strings may be just a local variable somewhere
> where kasprintf_strarray() is called.
> 
> I tend to NAK this change, rather you can update kernel-doc to explain
> why it's done this way (see above).
> 

It isn't as though it is going to make much difference to the memory
footprint.
Allocating an extra trailing NULL is just a bit safer.

	David

 
