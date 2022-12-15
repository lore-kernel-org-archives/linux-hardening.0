Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F71C4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 15 Dec 2022 19:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLOTWx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 15 Dec 2022 14:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLOTWx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 15 Dec 2022 14:22:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36013F06F
        for <linux-hardening@vger.kernel.org>; Thu, 15 Dec 2022 11:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671132125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vp2bThwHIB6WQ0sb6fAkdMYsQig9ewPh2eMzT18STEE=;
        b=djynl12W9o8MLYlL+E+LwWt5OaG4Y4JD+lOrBBpYd3uDPIsTZS5ytXI7JKO3miKgDnrq9+
        9n/ZVXBIyzjw53EO6E3yfmWslamapz4C3wo8hCy62QMsxt0je98FIRS7wfLLYvH9ixowjO
        0MIuUDLVBMSBh3Nxy0smv3IblN3rgpc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-Tis-Ll8mOVWIKyKvvNlgBQ-1; Thu, 15 Dec 2022 14:22:00 -0500
X-MC-Unique: Tis-Ll8mOVWIKyKvvNlgBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CF501C07828;
        Thu, 15 Dec 2022 19:21:59 +0000 (UTC)
Received: from redhat.com (unknown [10.2.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DB9C40C2064;
        Thu, 15 Dec 2022 19:21:58 +0000 (UTC)
Date:   Thu, 15 Dec 2022 14:21:55 -0500
From:   Peter Jones <pjones@redhat.com>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 00/26] x86_64: Improvements at compressed kernel stage
Message-ID: <20221215192154.fuu47gsultcqd3wh@redhat.com>
References: <cover.1671098103.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1671098103.git.baskov@ispras.ru>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Dec 15, 2022 at 03:37:51PM +0300, Evgeniy Baskov wrote:
> This patchset is aimed
> * to improve UEFI compatibility of compressed kernel code for x86_64
> * to setup proper memory access attributes for code and rodata sections
> * to implement W^X protection policy throughout the whole execution 
>   of compressed kernel for EFISTUB code path. 

Hi Evgeniy,

Aside from some minor patch fuzz in patch 6 due to building this in
today's Fedora rawhide kernel rather than mainline, this patch set works
for me.

Thanks!

-- 
        Peter

