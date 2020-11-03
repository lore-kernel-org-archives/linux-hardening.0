Return-Path: <SRS0=r0eN=EJ=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B485C8261C
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 10:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93B821D40
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 10:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXLKW2eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgKCKeg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 3 Nov 2020 05:34:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728602AbgKCKef (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 3 Nov 2020 05:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604399674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NeyfLxLqbPXnSVbIXerlFIoWQVVpshnlirjJvDi476c=;
        b=MXLKW2eqIxXz/kMc4QgmxEJjHXl1yOpHlfTmO0N7cZfXWo3CkvaC8t1xhtF+GKGKJSTDCZ
        0CsQvIdCI0S3/0X+ONuE+W44rb3pAXz0wovT5m5joLoxRZ7cHWSDqQ3bXvL43Zbl3yxaNJ
        SV8VQus5Ynhb5e1gWRtoImaDVkSx6kk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-9pmT0jXYPpibXCdCo9ZU8g-1; Tue, 03 Nov 2020 05:34:30 -0500
X-MC-Unique: 9pmT0jXYPpibXCdCo9ZU8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95DB580B72B;
        Tue,  3 Nov 2020 10:34:27 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-12.ams2.redhat.com [10.36.113.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAB611C4;
        Tue,  3 Nov 2020 10:34:23 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     libc-alpha@sourceware.org, Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/4] aarch64: Use mmap to add PROT_BTI instead of
 mprotect [BZ #26831]
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
        <f5eaa74cb7538382b2fd2439755386ac68f7c8db.1604393169.git.szabolcs.nagy@arm.com>
Date:   Tue, 03 Nov 2020 11:34:22 +0100
In-Reply-To: <f5eaa74cb7538382b2fd2439755386ac68f7c8db.1604393169.git.szabolcs.nagy@arm.com>
        (Szabolcs Nagy's message of "Tue, 3 Nov 2020 10:26:29 +0000")
Message-ID: <87v9embufl.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

* Szabolcs Nagy:

> Re-mmap executable segments if possible instead of using mprotect
> to add PROT_BTI. This allows using BTI protection with security
> policies that prevent mprotect with PROT_EXEC.
>
> If the fd of the ELF module is not available because it was kernel
> mapped then mprotect is used and failures are ignored.  It is
> expected that linux kernel will add PROT_BTI when mapping a module
> (current linux as of version 5.9 does not do this).
>
> Computing the mapping parameters follows the logic of
> _dl_map_object_from_fd more closely now.

What's the performance of this on execve-heavy workloads, such as kernel
or glibc builds?  Hopefully it's cheap because these mappings have not
been faulted in yet.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

