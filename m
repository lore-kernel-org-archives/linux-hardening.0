Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E28C83F14
	for <linux-hardening@archiver.kernel.org>; Thu, 31 Aug 2023 00:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344604AbjHaADr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 20:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344600AbjHaADq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 20:03:46 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AEDCDB
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 17:03:43 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-564af0ac494so286523a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 17:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693440223; x=1694045023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6VbAFF+mQ3qo4IqvELdDEKnEePt5q/NF9cOLJ4fQs4c=;
        b=NtTxdPtzChlphLzPyHgbZIRPE8CfMvug72kjB3FwHqjTOmd9myq9J8Tfk2maGVtMSH
         yjhSeihyHNphoN91OLUbGRPekKYBNHwR+yBDLAsLN2wBWUsMJaX3zfiRAH4lRXDrWZ5V
         jT7OhB8gOfuj/vLumSFrnyeecGERkxJtyCN/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693440223; x=1694045023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VbAFF+mQ3qo4IqvELdDEKnEePt5q/NF9cOLJ4fQs4c=;
        b=TnyTZhNjcLpbOVz61mc03iHGdIPFUjYfV9KlVpAa+FrgpgxEQpnXZul8rFcmNkX1gy
         LdXxioY2lHIa6nQxb2Kh6MZIvYcJVkqDAYSnu8SzC4pKCqIXQk57ukuq/k4NFmQOnhTf
         iMCZOOAlhhITenQLFUJ/YKEBRrZkp8NAOubF5yfGruhb5NEq5cwWMS5Qh4Gvvk8s9cx/
         IJiI80e2Zwl6ar87MRhP902qfUBNMQkV9+7mnqTwZGA7CPgy3wGWO104f4WqAH2g5Upd
         wpRxYrxvkID1nKEeaSLni0ISmKuDMStNq7G8ymF2ZL14Z4UvmdrXqHttqk7AODMhzGZX
         6/xA==
X-Gm-Message-State: AOJu0YxQeF0IzwhEpRvOeeRkmUUfdeBJNpSstHJh94clLv2L0/zNWydE
        iEId85mnr5eh1ZXbFVozncv2uw==
X-Google-Smtp-Source: AGHT+IGzXuhNKvCDESQE2QRrtYZBrvFQDlCXvQaZKzcZ7GFJqvb5A0aJYkymW5POHQPY6ycQWRimsg==
X-Received: by 2002:a17:90a:fa88:b0:26f:4685:5b66 with SMTP id cu8-20020a17090afa8800b0026f46855b66mr3639939pjb.8.1693440223411;
        Wed, 30 Aug 2023 17:03:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ft15-20020a17090b0f8f00b002684b837d88sm152885pjb.14.2023.08.30.17.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 17:03:42 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:03:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] kbuild: Show Kconfig fragments in "help"
Message-ID: <202308301702.4EB6F55@keescook>
References: <20230825194329.gonna.911-kees@kernel.org>
 <CAK7LNATcTw+btQVri7SBA8gFbDNMYz7D2gMQaoZp9sQGFjCw8Q@mail.gmail.com>
 <87ttsjlmho.fsf@mail.lhotse>
 <ZO2NVLipjlzIh0YS@bergen.fjasle.eu>
 <CAK7LNARjsB+LTBGRfWX68Ld7oehhuBv9SY8scoC=Xk8EJc-OHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARjsB+LTBGRfWX68Ld7oehhuBv9SY8scoC=Xk8EJc-OHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 29, 2023 at 11:57:19PM +0900, Masahiro Yamada wrote:
> The attached patch will work too.
> 
> I dropped the "in the first line" restriction
> because SPDX might be placed in the first line
> of config fragments.

Good call. Yes, this looks excellent; thank you! Do you want to send a
formal patch? Please consider it:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
