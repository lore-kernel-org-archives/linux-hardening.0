Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D200C143879;
	Tue, 23 Jul 2024 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773240; cv=none; b=pEjVinJClYEewk6DrPruCVfdLrXnLuOp8cyTFlN6i8TzHLM9ZgbmAVin8UWZfqCpp5bH0yEy7iSSCAtds9SVIsAO8sdfsxvQUryeZSF4NjN8hRdTEAeiPdfsq5YvUSa/w7D1rCECmyR3WsRRI9uJwzIWjbXpUTT29FHu8svFKUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773240; c=relaxed/simple;
	bh=PhiCGI+0lDmU9VS6dUAiwV/J0u9+jwn3moE1mGNrvpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqByYwgxBgipW1VvNREcX8W0RMNj9NC26IF4aQtZ/IMhfnkk/0P4SZ7MPt2QXZLwXZHxB1IiLQraU/sOu8NryXZt/16pQOiM6tss+fd8kV0cF6H/bHOFeQty2og4EwKidoDMO2VgiKtwpatmlZe+C4g8tFczeOg5da8ymziqvBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwhqugws; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwhqugws"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266edee10cso40505905e9.2;
        Tue, 23 Jul 2024 15:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721773237; x=1722378037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhiCGI+0lDmU9VS6dUAiwV/J0u9+jwn3moE1mGNrvpQ=;
        b=Wwhqugws7KDrpyhOKWWjv7cUuIICKN3bgu8GQELKkssyl/HoM8U1Ds1lFwlyjrwaKr
         N2TuAMAh4AV5m6oc5JyJBbPdI5bQnHr0otvYkSfRsBQj/N6t961nQDuZasOVRuWCdunp
         fpdUDGY7IO3UbiGVoj9ah2Jo2w1UUVMHsGc7MdajWSsUSiO+LnK1Lkr/w5Gaa4wNxIv3
         24W6Ye2jVeUERYQ5YSenu+pkCpYkiPsq5hmOObJ73KJBfFk7FztwtsPJ6n3Sk7S9bmIX
         CybDEIWGdGtq52CHBgpGw3FW9t1GAncX0jpk1Z99WtoQHXVFKA+WEdoEp9pTH7MQ20tx
         TTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721773237; x=1722378037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhiCGI+0lDmU9VS6dUAiwV/J0u9+jwn3moE1mGNrvpQ=;
        b=tPaakldFKBEyMb+DK/ZWvw/11lNTcCeEcDcoaw/ko2ScGTIVFVINauZHavQx6Hg2Tt
         Zod/JKA3Bkf87SIg6yubtWJC2Hbf0vUI+6tLwDpSvnh/1/rE5P5qHVlO9ak3iI9TTUSD
         Fj0I4Zc2VMBOPMPkL91zZMgdfaL4cqrpZcjol4IsxppAW0k/EC400a0rg2MWAfivTE2j
         nGrho4pA9PQGib+ypCxB59Tt7mJGennuwNjuWx2bglcChKIO/WRNrFSe8hXFuFYIeR9v
         q779TfwW0N1iUqmPypEZh/fuFbhVc2IoctR3w0Y5ba1lrMg4srBUd1xsPKp95JizRBE7
         SnKg==
X-Forwarded-Encrypted: i=1; AJvYcCW+I9gAADCvML2B0xTn1skpDWfSPY1pmAIWdrIdCFYE/aSrqecOItZbXxdmeiYSG9qOKsj8O/0XgbXjMmZDmJK4MZ13hbbJuDZLD8wojldWyIN7bIctqE27ouKeDM8ZvjP44AhHOWG98PTLN6iP
X-Gm-Message-State: AOJu0Yy6BP8S8bPqo69B08UeM9rC5ZFOIjRU6ORituX3hO/Ffe30P3AJ
	lgsnp92JDZqAoIX1QswqzycRfIO0EKz2xdgwdt30I0etTLOltJjkyrWTvTzVpXuQOGzR7AWANlE
	EbZk7qtK5y4ZtAnsHkmBrNs/gEK8=
X-Google-Smtp-Source: AGHT+IG0VqeACNNp75xPFIsOP06VyHtdPzXgXp9EVPC8LjE+ce4xQq68nuZDpbQzIrjdK+Lwmyu5YW5gToacP2SXhKE=
X-Received: by 2002:a05:600c:19ce:b0:427:dac4:d36 with SMTP id
 5b1f17b1804b1-427f954287emr1330255e9.7.1721773236693; Tue, 23 Jul 2024
 15:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407231547.389c0ad2-oliver.sang@intel.com>
In-Reply-To: <202407231547.389c0ad2-oliver.sang@intel.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 24 Jul 2024 00:20:25 +0200
Message-ID: <CA+fCnZd2G5Zm4tcW1qTEHrzDAM=K6apCSftYKgLMETJ4FBGNAA@mail.gmail.com>
Subject: Re: [linus:master] [kasan, fortify] 2e577732e8: BUG:KASAN:global-out-of-bounds_in_usb_copy_descriptors
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Erhard Furtner <erhard_f@mailbox.org>, 
	Nico Pache <npache@redhat.com>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Daniel Axtens <dja@axtens.net>, Dmitry Vyukov <dvyukov@google.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 10:51=E2=80=AFAM kernel test robot
<oliver.sang@intel.com> wrote:
>
> Hello,
>
> we noticed this is a fix commit, however, we don't have enough knowledge =
to
> determine if new KASAN issue is expected actually after this fix.
> so we just made this report FYI what we observed in our tests.
>
>
> kernel test robot noticed "BUG:KASAN:global-out-of-bounds_in_usb_copy_des=
criptors" on:
>
> commit: 2e577732e8d28b9183df701fb90cb7943aa4ed16 ("kasan, fortify: proper=
ly rename memintrinsics")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Hi,

Yes, that patch might uncover new bugs that previously were not
detectable. There's still a chance that something is wrong with KASAN
and it reports a false positive, but most likely, this report is a
real issue.

Thank you!
