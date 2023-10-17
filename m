Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DAEBE
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B5lNrtyZ"
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9070B109
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 11:39:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso973958766b.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697567939; x=1698172739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=USkbb5/cH3vJp4KF5jTF8rcY5cuD/NJi1SRBLDhJQGQ=;
        b=B5lNrtyZVUEi4UcfcSavGLBauQId9QEWDJOCL7fhztpaX3WgnR8k7hJyQImlcgy3C1
         tS6R5/+ix1tproAO3V8Q5/DssOrxUxYUOIBqBxVm3gj6nhE+JcR1uZQVXkOiAObfE7wq
         n6WXqxWc8K7+1b4LDTvIl4cHEoIcAjweoh9zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697567939; x=1698172739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USkbb5/cH3vJp4KF5jTF8rcY5cuD/NJi1SRBLDhJQGQ=;
        b=WWy4Jj7vB85b8pogG0onJ2t/2ydpdxPKk+6zTvT8ZInhoPbCNbtmHbTyTnTW0cWDc8
         iEaL6wGqK7xop1zg3bh7v2uduS+/wBrakRg+v54JoTsSgPnN4RNtFRum4fWukle1x3qH
         Hp+rPYak4ZwDJf1vUHDYF9NxS1RqveS6QAvNZX9wr9FIFjIRhtVBCHf1BrhgttpxdCRR
         bBh3rz8wfDteXrvIkzn6zxJRoaAP5xWHeNhMHYU24Go6lNmwvajtII/Ogn71cqrKoZvz
         ygUsCSjYGjpeo7IcEhBjW+YIO0WrKEfi8RGoKDLyovEWOdDJa4tYw3myDbVIrduJ03HP
         /5dw==
X-Gm-Message-State: AOJu0YzY0qPLGXekqsJob+57GdaO9Kqt7/fQaMP5MfreptuR4tJEEPu3
	8yjxzVLXy5Dn0eYJsZv3Jsj0MD0dEBBJc3JNDBDgI/qr
X-Google-Smtp-Source: AGHT+IFKn7qv/EyrQ6hnuaxgolNBfvPkRvojNP6oPXowiV2EYZlU5CPhw5dWgYm3bC2RXQWBu6RQ4A==
X-Received: by 2002:a17:907:744:b0:9bf:63b2:b6e2 with SMTP id xc4-20020a170907074400b009bf63b2b6e2mr2517208ejb.26.1697567938769;
        Tue, 17 Oct 2023 11:38:58 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a4-20020a170906684400b009ad75d318ffsm258028ejs.17.2023.10.17.11.38.58
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 11:38:58 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso5970756a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 11:38:58 -0700 (PDT)
X-Received: by 2002:a17:906:4fc7:b0:9b2:b149:b81a with SMTP id
 i7-20020a1709064fc700b009b2b149b81amr2302073ejw.64.1697567917353; Tue, 17 Oct
 2023 11:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com>
 <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com>
 <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com> <55960.1697566804@cvs.openbsd.org>
In-Reply-To: <55960.1697566804@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Oct 2023 11:38:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjS=xg12RVQdTNxEurjo21eXQBQO0D5My6Aox4LCfsO1A@mail.gmail.com>
Message-ID: <CAHk-=wjS=xg12RVQdTNxEurjo21eXQBQO0D5My6Aox4LCfsO1A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Jeff Xu <jeffxu@google.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, sroettger@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	surenb@google.com, alex.sierra@amd.com, apopple@nvidia.com, 
	aneesh.kumar@linux.ibm.com, axelrasmussen@google.com, ben@decadent.org.uk, 
	catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk, 
	ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com, corbet@lwn.net, 
	wangkefeng.wang@huawei.com, Liam.Howlett@oracle.com, lstoakes@gmail.com, 
	willy@infradead.org, mawupeng1@huawei.com, linmiaohe@huawei.com, 
	namit@vmware.com, peterx@redhat.com, peterz@infradead.org, 
	ryan.roberts@arm.com, shr@devkernel.io, vbabka@suse.cz, 
	xiujianfeng@huawei.com, yu.ma@intel.com, zhangpeng362@huawei.com, 
	dave.hansen@intel.com, luto@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 17 Oct 2023 at 11:20, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> The only case where the immutable marker is ignored is during address space
> teardown as a result of process termination.

.. and presumably also execve()?

I do like us starting with just "mimmutable()", since it already
exists. Particularly if chrome already knows how to use it.

Maybe add a flag field (require it to be zero initially) just to allow
any future expansion. Maybe the chrome team has *wanted* to have some
finer granularity thing and currently doesn't use mimmutable() in some
case?

                  Linus
