Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4988BC4338F
	for <linux-hardening@archiver.kernel.org>; Mon,  2 Aug 2021 09:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3586A610CC
	for <linux-hardening@archiver.kernel.org>; Mon,  2 Aug 2021 09:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhHBJwU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233081AbhHBJwU (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 2 Aug 2021 05:52:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CAF760F58;
        Mon,  2 Aug 2021 09:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627897930;
        bh=zptMS4fel5KD7SXlEYuE6VYDne/g+jcVh1jlBH3XsIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uly2ZZOHomVUxvxd4dtL3RHiqyBuFngfFJP5WtyCMZ9sZmFe3E2SxD4AVGxe/Npun
         VEZvvoOpQwuY77mjdqPC21GXK97TED11iXTaGT5BmNObZac9RjhkKuwsH012QNTSq7
         bie4+LZHo0MvqKxmD4LBG3NTbU7ZmQjvCrMVIesIToDvQDF22ZDmK1qCueBRbkTaD0
         VEWwvzV76H4ldtNCyPTpXoKohpkol+Q+Z4PMkv5+TJeTv2VywGdOR/LhGAgEQ81d0x
         Svg5JFxGV4m77MDo9JcqTp5RL04Ih1taHe71wLE6/PnRFgyUGo6SJvx6bA6gJNepRG
         jtET/j5QcQbTg==
Date:   Mon, 2 Aug 2021 11:52:06 +0200
From:   Robert Richter <rric@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/edac/edac_mc: Remove all strcpy() uses
Message-ID: <YQfARq44bAIR/HEi@rric.localdomain>
References: <20210801143558.12674-1-len.baker@gmx.com>
 <YQe4n5H00g3xhSbQ@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQe4n5H00g3xhSbQ@rric.localdomain>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 02.08.21 11:19:33, Robert Richter wrote:
> On 01.08.21 16:35:58, Len Baker wrote:
> 
> > @@ -1114,10 +1116,12 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
> >  			*p = '\0';
> >  		} else {
> >  			if (p != e->label) {
> > -				strcpy(p, OTHER_LABEL);
> > +				strscpy(p, OTHER_LABEL, left);
> > +				left -= strlen(OTHER_LABEL);

Another note: Other parts of the code use 'len' instead of 'left', so
if you could change that too?

Thanks,

-Robert

> >  				p += strlen(OTHER_LABEL);
> 
> Those both must be strlen(p) now as otherwise 'left' could underflow
> (and p overflow).
> 
> -Robert
> 
> >  			}
> > -			strcpy(p, dimm->label);
> > +			strscpy(p, dimm->label, left);
> > +			left -= strlen(p);
> >  			p += strlen(p);
> >  		}
> > 
