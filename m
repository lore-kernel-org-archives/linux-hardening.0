Return-Path: <SRS0=8UcS=EK=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B23C4741F
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 14:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5868820756
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 14:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuehmNZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgKDOp6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:45:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729898AbgKDOp5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 Nov 2020 09:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604501156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/qDMVtos7dYdtcZu5rNmBGlotvjjozf9G0PRDDGQXs=;
        b=FuehmNZcdrcy7rGZnQ6XxJIDWzKhga0wN8DWf9q9lAn5+h7YMqS/iRfTkVcDYtLce2bqEv
        rpV8BHUYd8xNdGdP48JbZTM5DM6puvHJbrMDqYBiiEC5BY4k19KWWdwDQlVcWqmpb8BpPz
        Cs/+yMIC2jWRjTSFP4fauRvai2JRQJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-jgwp6zJgNeGan1kW1fiemg-1; Wed, 04 Nov 2020 09:45:52 -0500
X-MC-Unique: jgwp6zJgNeGan1kW1fiemg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D1931084C80;
        Wed,  4 Nov 2020 14:45:50 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-12.ams2.redhat.com [10.36.113.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3E125B4D8;
        Wed,  4 Nov 2020 14:45:45 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>, libc-alpha@sourceware.org,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/4] aarch64: avoid mprotect(PROT_BTI|PROT_EXEC) [BZ
 #26831]
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
        <20201103173438.GD5545@sirena.org.uk>
        <8c99cc8e-41af-d066-b786-53ac13c2af8a@arm.com>
        <20201104085704.GB24704@arm.com> <20201104144120.GD28902@gaia>
Date:   Wed, 04 Nov 2020 15:45:44 +0100
In-Reply-To: <20201104144120.GD28902@gaia> (Catalin Marinas's message of "Wed,
        4 Nov 2020 14:41:21 +0000")
Message-ID: <87ft5p2naf.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

* Catalin Marinas:

> Can the dynamic loader mmap() the main exe again while munmap'ing the
> original one? (sorry if it was already discussed)

No, we don't have a descriptor for that.  /proc may not be mounted, and
using the path stored there has a race condition anyway.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

