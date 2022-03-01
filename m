Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2284AC433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Mar 2022 04:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiCAEWS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiCAEWQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 28 Feb 2022 23:22:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6278B31365;
        Mon, 28 Feb 2022 20:21:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7CFC609EE;
        Tue,  1 Mar 2022 04:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B9EC340EE;
        Tue,  1 Mar 2022 04:21:33 +0000 (UTC)
Date:   Mon, 28 Feb 2022 23:21:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        David Gow <davidgow@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Magnus =?UTF-8?B?R3Jvw58=?= <magnus.gross@rwth-aachen.de>,
        kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: Introduce KUnit test
Message-ID: <20220228232131.4b9cee32@rorschach.local.home>
In-Reply-To: <CAGS_qxoXXkp2rVGrwa4h7bem-sgHikpMufrPXQaSzOW2N==tQw@mail.gmail.com>
References: <20220224054332.1852813-1-keescook@chromium.org>
        <CAGS_qxp8cjG5jCX-7ziqHcy2gq_MqL8kU01-joFD_W9iPG08EA@mail.gmail.com>
        <202202232208.B416701@keescook>
        <20220224091550.2b7e8784@gandalf.local.home>
        <CAGS_qxoXXkp2rVGrwa4h7bem-sgHikpMufrPXQaSzOW2N==tQw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 28 Feb 2022 17:48:27 -0800
Daniel Latypov <dlatypov@google.com> wrote:

> He also prototyped a more intrusive alternative to using ftrace and
> kernel livepatch since they don't work on all arches, like UML.

Perhaps instead of working on a intrusive alternative on archs that do
not support live kernel patching, implement live kernel patching on
those archs! ;-)

It's probably the same amount of work. Well, really, you only need to
implement the klp_arch_set_pc(fregs, new_function); part.

-- Steve
