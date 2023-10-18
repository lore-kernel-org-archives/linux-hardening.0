Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C8A3B2AE
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WlSvcMi5"
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A76119
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 11:54:59 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41b19dda4c6so48171cf.1
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697655298; x=1698260098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFJlA+mQhi+0DERBwp78bB/+mqro8rSJvhQZ9F+v2NE=;
        b=WlSvcMi5F/jYXxVjjQcOVuG7FVY9JhBio0abDr6dtY+dGMzncWxQZdEqvyjdLwY3H5
         mgSRekPrWheEXYi4QVxifQo8Z8b5FxJZX4fDGDhXv4Tv8OGRmSnFFAf8HoZceAyu5r63
         J9k7UcPcoJgm4g8JjwCTAsoSkgVTa9J7OCIIK3G+XQrp8okByvd4G44x5Cntvz5V8Vgq
         ZYmUuQTUEhhOxagJPOZYcS3LbvLUJtxj7KL7Tz4KP2f4EWQK1U9/pZk5m/NAuWfoQg2i
         5bLKP4tBEULzUa5+vGvAyBdxYUxjJa+ue2vgWmh4WBa9NQcelU9GLW7N50/6hxDU90kA
         H0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697655298; x=1698260098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFJlA+mQhi+0DERBwp78bB/+mqro8rSJvhQZ9F+v2NE=;
        b=RSuUlYwla8BDdtltnlqYjEB1kj+TA2WzwsUFK7cvCzUhLuVskJd4n6DlbIFVdxkLi/
         UE5x19FdNn4rr+kLXUJ4weBtoRoU6RIWvxWiqda08Y8sNdjzf6J2nVnr5tAoQrB12nF8
         1mSaQU50x0ZT32iDDMv89W2yubv5j6NNVCAqeBP7sOvvVOqPPpYpO1AYYuvc/ZkD8NyO
         Tv/YONamAFmShF1tTHaD97QErHcxv6K9Z+E1SjQhGeHhzf9vfkeA8ugSdJg18AsKl+67
         1ibaPuZsYw0MFIhwoRiRkuYhinO33L2BzduRstzUUafZ9pugV009JE4mcNRMTVLAh2yA
         fBxA==
X-Gm-Message-State: AOJu0YxPdQwkHxQdf0WKKiA1/I6iMdPis2Wdg9aUMT5jAMcXR1PIkkbI
	2d87CF2hw5T2y4OO9wGGo1ViW7m/grRXKjjFDixmdw==
X-Google-Smtp-Source: AGHT+IGjizzkFJ61gHRpVi03W6jxKFHsg7oR29EE+XHiKGg+Nd1AGPkE/bY4MhXNSrPSxo096Ldf5GQvn/xYA+BV/to=
X-Received: by 2002:a05:622a:668a:b0:419:77b7:da5f with SMTP id
 hx10-20020a05622a668a00b0041977b7da5fmr39818qtb.11.1697655298459; Wed, 18 Oct
 2023 11:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com>
 <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com>
 <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com>
 <55960.1697566804@cvs.openbsd.org> <CALmYWFs81T=XnT=AXQTo0+9FXo=OBAV_4rrYPSn9-16O-gBTZg@mail.gmail.com>
 <95482.1697587015@cvs.openbsd.org> <CALmYWFtQX57Z7ttKxrdXQH4QupFn4vi5KfizUBH9NkmP-S1JDw@mail.gmail.com>
 <ZS/3GCKvNn5qzhC4@casper.infradead.org>
In-Reply-To: <ZS/3GCKvNn5qzhC4@casper.infradead.org>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 18 Oct 2023 11:54:22 -0700
Message-ID: <CALmYWFu_uY=cWzAQaLtS0CdNrm+cO7tKz4sY2Ff02WQ8mGUUXw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To: Matthew Wilcox <willy@infradead.org>
Cc: Theo de Raadt <deraadt@openbsd.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	sroettger@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, jannh@google.com, surenb@google.com, alex.sierra@amd.com, 
	apopple@nvidia.com, aneesh.kumar@linux.ibm.com, axelrasmussen@google.com, 
	ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com, 
	dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com, 
	corbet@lwn.net, wangkefeng.wang@huawei.com, Liam.Howlett@oracle.com, 
	lstoakes@gmail.com, mawupeng1@huawei.com, linmiaohe@huawei.com, 
	namit@vmware.com, peterx@redhat.com, peterz@infradead.org, 
	ryan.roberts@arm.com, shr@devkernel.io, vbabka@suse.cz, 
	xiujianfeng@huawei.com, yu.ma@intel.com, zhangpeng362@huawei.com, 
	dave.hansen@intel.com, luto@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 8:17=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> Let's start with the purpose.  The point of mimmutable/mseal/whatever is
> to fix the mapping of an address range to its underlying object, be it
> a particular file mapping or anonymous memory.  After the call succeeds,
> it must not be possible to make any address in that virtual range point
> into any other object.
>
> The secondary purpose is to lock down permissions on that range.
> Possibly to fix them where they are, possibly to allow RW->RO transitions=
.
>
> With those purposes in mind, you should be able to deduce for any syscall
> or any madvise(), ... whether it should be allowed.
>
I got it.

IMO: The approaches mimmutable() and mseal() took are different, but
we all want to seal the memory from attackers and make the linux
application safer.

mimmutable() started  with "none of updates to the sealed address is
allowed once marked as immutable", this includes from within kernel space
including driver, or any new syscalls. It is reasonable to me.

mseal() starts with 4 syscalls from userspace, which is just a way (among m=
any
other ways) to demo what memory operation can be sealed, which happens
to meet what Chome wants.  This is an RFC, I appreciate your input.

Best regards,
-Jeff
