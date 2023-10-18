Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722324421
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="jsDMH0m7"
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CEEFA;
	Tue, 17 Oct 2023 20:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=TeLxSCjetO
	scvlEvELbRNGiU7p09LOhnflOe0RLiFYk=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=jsDMH0m7ttDB4eio1pdXKIv+PU40k6qiw
	zsw3444aBI1uB65saDcHHuqszFN9VO6n8OjKIQf2Ts7V9vzWhYc1vorKp6BAjYJ5TybDHZ
	BvWDWj9zEYgWVYL6omIAh/g+WzNcryLAjXHgWMehKATTgnxao7mv8QxH/6QA2PKvsSplxP
	fWnsNhsy+y29yxNnZezm4MZL/Yv1HQEOk+V2Db/K2nwyV9n8ufjhKDkEBwLfLGNbg+gxvH
	ItZxcvH+FnzT0uMHkfDndP/1RIZXXTgHIp6rerLNbc+kRja6BSjkcT/kI0IVyBB4QnT2m0
	AXylmYHuBgrppQukB35Lv8sbd+w+g==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id f1e58267;
	Tue, 17 Oct 2023 21:37:20 -0600 (MDT)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Jeff Xu <jeffxu@google.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>, jeffxu@chromium.org,
    akpm@linux-foundation.org, keescook@chromium.org,
    sroettger@google.com, jorgelo@chromium.org, groeck@chromium.org,
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
    linux-mm@kvack.org, jannh@google.com, surenb@google.com,
    alex.sierra@amd.com, apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
    axelrasmussen@google.com, ben@decadent.org.uk,
    catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
    ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
    corbet@lwn.net, wangkefeng.wang@huawei.com, Liam.Howlett@oracle.com,
    lstoakes@gmail.com, willy@infradead.org, mawupeng1@huawei.com,
    linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
    peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
    vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
    zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
    linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
In-reply-to: <CALmYWFtQX57Z7ttKxrdXQH4QupFn4vi5KfizUBH9NkmP-S1JDw@mail.gmail.com>
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com> <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com> <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com> <55960.1697566804@cvs.openbsd.org> <CALmYWFs81T=XnT=AXQTo0+9FXo=OBAV_4rrYPSn9-16O-gBTZg@mail.gmail.com> <95482.1697587015@cvs.openbsd.org> <CALmYWFtQX57Z7ttKxrdXQH4QupFn4vi5KfizUBH9NkmP-S1JDw@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@google.com>
   message dated "Tue, 17 Oct 2023 20:18:47 -0700."
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45247.1697600240.1@cvs.openbsd.org>
Date: Tue, 17 Oct 2023 21:37:20 -0600
Message-ID: <53481.1697600240@cvs.openbsd.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jeff Xu <jeffxu@google.com> wrote:

> In linux cases, I think, eventually, mseal() will have a bigger scope than
> BSD's mimmutable().

I don't believe that, considering noone needed this behaviour from the VM
system in the last 4 decades.

> VMA's metadata(vm_area_struct) contains a lot
> of control info, depending on application's needs, mseal() can be
> expanded to seal individual control info.

> For example, in madvice(2) case:
> As Jann point out in [1] and I quote:
> "you'd probably also want to block destructive madvise() operations
> that can effectively alter region contents by discarding pages and
> such, ..."

Then prohibit madvise(MADV_FREE) on all non-writeable mappings that are
immutable.  Just include this in the set of behaviours. Or make it the
default.

Don't make it an option that a program needs to set on pages!  Noone
is going to call it.  Most programs don't know the addresses of the
*REGIONS* they would want to do this for.

Does your program know where libc's text segment starts and ends?
No your program does not know these addresses, so the parts of the
'system' which do know this needs to do it (which would be ld.so or
the libc init constructors).

If madvise(MADV_FREE) is so dangerous..  say you have a program that
would call through abort(), but you know a zero there can make the
abort not abort but return, then is it bad to let the attacker do:

   madvise(&abort, pagesize, MADV_FREE)

If that is bad, then block it in a smart way!  Don't make a programmer
of an application figure out how to do this.  That results in a defense
methodology where a handful of programs self-protect, but everything
else is unprotected or unprotectable.  That is shortsighted.

> Another example: if an application wants to keep a memory always
> present in RAM, for whatever the reason, it can call seal the mlock().

Please explain the attack surface.

> I think I  explained the logic of using bitmasks in the mseal()
> interface clearly with the example of madvice() and mlock().

It is clear as mud.
