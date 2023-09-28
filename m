Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A6C8BF4
	for <linux-hardening@vger.kernel.org>; Thu, 28 Sep 2023 12:55:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EB2199
	for <linux-hardening@vger.kernel.org>; Thu, 28 Sep 2023 05:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695905728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qI4XghGXIMa5N9aYtul1yzQ/Grglthn81P30tLktnuU=;
	b=VkW+23p3t+DLbC9yQBrpTX5iCnXkDrZ1VFT3pMNFsoz3G0r60qZwPjLjjemyTgVtCmST3T
	ElTW05x2aryT4BMswNOvKOybCyUtRxRJrNIuenZjSsqT32+8PnwCmHHzPE+mAFm2pV+4O1
	obb3VHYHE2cs/4arEbsWkPvlNbZl4sE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-inUKFeWLP6KkTToz5kZcxw-1; Thu, 28 Sep 2023 08:55:27 -0400
X-MC-Unique: inUKFeWLP6KkTToz5kZcxw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-774382db0a5so1316514685a.2
        for <linux-hardening@vger.kernel.org>; Thu, 28 Sep 2023 05:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695905726; x=1696510526;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qI4XghGXIMa5N9aYtul1yzQ/Grglthn81P30tLktnuU=;
        b=EqqGfheIGWg2GTiExDTtz6Hs3wd1DjRPZBUhyv+L+KwRk+LbbugD4MTvIEKgXhWeFi
         icv2L16GzWFrUnOF+KTCsAdKq0EHLa5RSQL6Mvd9vrMLGAtioCy3csb1C4r/e2Jjmisq
         EJGTNDHjKJy1kFX3Ra6vIEgM6Zvg2iECv5580OqcvtUJ7eh/qN9PEll/Xowu27r3DomF
         TWcgdGg00yCCz2x1yqM/6f2/OXaAPs+uM0jIzUiIoiVrTeGZ4iu68NRqID2NhgnCtM4z
         Eh9RCeZ7j5wplBps3xzNNg5J9e+RtBWBnDDdFiiUgCDpS0jqntz+3hbV5HlGkDQwb43c
         +qTQ==
X-Gm-Message-State: AOJu0YxmdIlEFhneXkvW4n63aKk/Qcqhq8jXupsV7pl9JR0/ZpwRxiiz
	5cGyiKKw4yM48bNdSqDLqFPGZgZ5SEVDUBFLKghsKky+aP3CKq2r+Y6938Hy2jE1soLsfLkCLvB
	z4vBcO8tTF51HlgOzH1ByBxcNQeg6
X-Received: by 2002:a05:620a:430e:b0:76c:c601:367f with SMTP id u14-20020a05620a430e00b0076cc601367fmr923546qko.36.1695905726466;
        Thu, 28 Sep 2023 05:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMXwEot4+7yhPCsisxUY3uf2TL6o8grOmBxp49L8okK6ad+7nPn/hioefoDjWOBvMUnPfWlQ==
X-Received: by 2002:a05:620a:430e:b0:76c:c601:367f with SMTP id u14-20020a05620a430e00b0076cc601367fmr923525qko.36.1695905726184;
        Thu, 28 Sep 2023 05:55:26 -0700 (PDT)
Received: from rh (p200300c93f19a200f43f623a676b2d27.dip0.t-ipconnect.de. [2003:c9:3f19:a200:f43f:623a:676b:2d27])
        by smtp.gmail.com with ESMTPSA id c1-20020ac84e01000000b00403ad6ec2e8sm3676249qtw.26.2023.09.28.05.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:55:25 -0700 (PDT)
Date: Thu, 28 Sep 2023 14:55:22 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Kees Cook <keescook@chromium.org>
cc: Eric Biederman <ebiederm@xmission.com>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
    Pedro Falcato <pedro.falcato@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/4] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
In-Reply-To: <20230927033634.make.602-kees@kernel.org>
Message-ID: <6208fd50-43cd-85fc-e9a6-f10281a15902@redhat.com>
References: <20230927033634.make.602-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 26 Sep 2023, Kees Cook wrote:
> This is the continuation of the work Eric started for handling
> "p_memsz > p_filesz" in arbitrary segments (rather than just the last,
> BSS, segment). I've added the suggested changes:
>
> - drop unused "elf_bss" variable
> - report padzero() errors when PROT_WRITE is present
> - refactor load_elf_interp() to use elf_load()
>
> This passes my quick smoke tests, but I'm still trying to construct some
> more complete tests...

I've repeated all my tests with this one - no issues found.

Thanks,
Sebastian

