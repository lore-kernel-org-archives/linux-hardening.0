Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3728EB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jun 2023 09:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjF1Jk6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Jun 2023 05:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjF1H4L (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Jun 2023 03:56:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0566F30F0;
        Wed, 28 Jun 2023 00:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+WP3Kdd4a8kNUG84zf2b3FF04bm6RA3v9ntpchRkeW4=; b=nwXB9AbY9psyBzrYdDqhZgN+uK
        4cXll5VhDslN3I0xrk9U3Qpu5mtRnhLENnZeEQzpGmzGVFllE/PL8DrCz9zsbGq1LOZEjBzC7qDH7
        ws1LHoSKSZEKl7tI0YUMYul+viUB2r16Z7RFSie44rjjNDCyICNP+iEhb8nqLeZt25hrb0bzuTzOg
        XXkdzoYDPDoaQypMX2DfWp0UDin0Cal9N9QJClYkSaVZhequQcz1aj+hFNWTux/4yBCh5ifzugHCY
        b0vuaVmAnkVN4whPbmj6YR1Qlj83AlAnUABkaNm4Akkk0c7xN7X+StVehNAtPupW7OHXFgmseNijn
        IfVx15Ug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEOX7-00Ewxn-0M;
        Wed, 28 Jun 2023 06:20:05 +0000
Date:   Tue, 27 Jun 2023 23:20:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arne Welzel <arne.welzel@corelight.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fangrui Song <maskray@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        John Stultz <jstultz@google.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Marco Elver <elver@google.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Simon Horman <simon.horman@corigine.com>,
        Song Liu <song@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] hardening updates for v6.5-rc1
Message-ID: <ZJvRFZeYq6ZWLAWj@infradead.org>
References: <202306271729.813C8788@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306271729.813C8788@keescook>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 27, 2023 at 05:34:57PM -0700, Kees Cook wrote:
> - The under-development compiler attribute __counted_by has been added
>   so that we can start annotating flexible array members with their
>   associated structure member that tracks the count of flexible array
>   elements at run-time. It is possible (likely?) that the exact syntax
>   of the attribute will change before it is finalized, but GCC and Clang
>   are working together to sort it out. Any changes can be made to the
>   macro while we continue to add annotations. As an example, I have a
>   treewide commit waiting with such annotations found via Coccinelle:
>   https://git.kernel.org/linus/adc5b3cb48a049563dc673f348eab7b6beba8a9b
>   See commit dd06e72e68bcb4070ef211be100d2896e236c8fb for more details.

So I've been following the discussion of that feature for clang and
I can't wait to actually be able to use it.

But this feels a bit premature to me, not only due to the ongoing
discussions on the syntax, but more importantly because I fear it
will be completely misued before we have a compiler actually supporting
available widely enough that we have it in the usual test bots.

