Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53127C433EF
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Mar 2022 17:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiCDRR4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Mar 2022 12:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbiCDRRr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Mar 2022 12:17:47 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297041CD9DE
        for <linux-hardening@vger.kernel.org>; Fri,  4 Mar 2022 09:17:00 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D2D902C0;
        Fri,  4 Mar 2022 17:16:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D2D902C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1646414219; bh=fmFzS+MsVogVoM8EQElzON04Qt45ag1MEZQ4omlt00s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Awy3x6wC6HmEJtnx+WGj5N/u1bExg4vlLF6PvR+4X+TGT+Ja7x1paArqSoCce9aD1
         aUFt7B56ZVkgya6L9V+CC/PUE9zLFFV2RWnkedN8yF6I/yqZxVkct23GAAPH+v7s88
         69Bkhpl9LZ/qfS+PliPIA4+RxjtPJKoC7zFWTTTkzou67PGnUX3wLhOoBIYWLBY5XJ
         BV6OMzjq0xz9WiNgAyQOU949MRL4D+ONqz+kvWUWs5fgOwQeIfR/y1tIQY9KOkmuUE
         XEim1+y/qGf1tSlDt2jgSFdv67nq8bnyG923M29vsJliRBmfGNS28BuRGHYWVrsSeB
         kWp/MCizFn4SA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Zacchiroli <zack@upsilon.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wenwen Wang <wenwen@cs.uga.edu>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Documentation/process: Add Researcher Guidelines
In-Reply-To: <202202251044.F509C7F3@keescook>
References: <20220224001403.1307377-1-keescook@chromium.org>
 <974cf8f2-06f3-99a5-9a77-6d7b7cc8271a@leemhuis.info>
 <202202251044.F509C7F3@keescook>
Date:   Fri, 04 Mar 2022 10:16:58 -0700
Message-ID: <871qzhhc39.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Feb 24, 2022 at 09:19:24AM +0100, Thorsten Leemhuis wrote:
>> Hmm, the intro for "Documentation/admin-guide/" states that "The
>> following manuals are written for users of the kernel", but the added
>> text afaics providing nothing regular users care about. So wouldn't it
>> be better if this lived below Documentation/process/ ? It might not a
>> really good fit either, but I'd say it's the better place.
>> 
>> But well, the best person to know is Jonathan, who is listed as a
>> Co-developer above, so maybe I'm wrong my suggestion is a bad one.
>
> I started in process/ and eventually settled on admin-guide/ since that's
> basically the "front page". But I agree, there isn't an obviously correct
> place for it.

Sorry, been a bit distracted...when we were working on this I was more
focused on the text than the location.  My own feeling is that
Documentation/process is a better place for this - that's where we tell
the world how to work with the kernel community, after all.  I'm not
going to dig in my heels and fight about it, but that's my sense.

Otherwise, it kind of seems like this is ready to go in. I'd like to
apply it before the merge window; lemme know where you want it in the
end and we can get it done.

Thanks,

jon
