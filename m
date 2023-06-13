Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABF3EB64D7
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jun 2023 20:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjFMU6q (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjFMU6o (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jun 2023 16:58:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB7C19B1
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 13:58:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so650a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 13:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686689921; x=1689281921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAKJIDFpZuSxjbq11Sivsx7j8EhbMPSluCQPJIPFOeY=;
        b=3wvY99jVUR4aRlrh2JJ3n4XR/82x8Kmm6awdM03ZnnU+AjfX8vl1vS9BU6SUoQOgWL
         yKQCBUjxJf9WazFAHgYv7mpumPoB44lvFBO6dsdaC+eQAw6ciu8hD5HacFQ5P4OkRt1H
         LZSb1MZD5UgpFuigznxpri1Q17ISsXb7ZJto36DI2PBRcHgk4y6fu6W3PKWvFPqK5WoZ
         dtXqxEwL0K09H1j8crTja0ZJGkZTXFE/+QL5t4Ojh2wze1SDTwbkZn2rEUGBqVwT7z8Q
         3YX0m4SZaALjPCmLp/hQvKb/7ohYWQj60SUKXEisBqd4oyHujuXiHDO4iz0dFsiiwPp2
         9Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686689921; x=1689281921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAKJIDFpZuSxjbq11Sivsx7j8EhbMPSluCQPJIPFOeY=;
        b=dYzz9dvFODVQ4nH6pCOwF1qZPEqy59iNRJ+h1S69KyPdPHtogPMpZKITCwWUiuEa7/
         0TNaqUHErKRj7qN6vX30mZvx0US7A4e1OVV+6WmOSnLyAqQStX/BT8ulRr7igIdJ4Txx
         d6pDvDz4ZfsUgS+Q9WrTyuPALksbOiL+xCSWKoGYlAicJzavKa7E8UUGfRA5fUj7I5e8
         4Jq75jy2u3gr3U9eJ6uOhPMM3ETQAv+paSv+t2sVmJjZL3Ibps4KejX1lKUNcTDTXOgk
         g3/32XZqDvgT6XZfozCjNTmjysf1C5Ul2S9AUZX+dUXWqsDHDhbo36Y3/IV8cW6SSavg
         FOUQ==
X-Gm-Message-State: AC+VfDx1a34+hHGtdH+mcWfoz9huuXetMZLgkQ9VHPN077bGVmdv+F7j
        0dcgw+HHHWiZkOEoAONjZTReCypfHyDDk9ErJaLyuA==
X-Google-Smtp-Source: ACHHUZ4+Sx/OVELnVq7juOYWbkf7lKyjpQO6KHH4OztkJBMF/OX6VD0uZMZsQf3W8LLsd0ZxTGuxxVFlR4EQMy5V6SI=
X-Received: by 2002:a50:baa9:0:b0:510:b2b7:8a78 with SMTP id
 x38-20020a50baa9000000b00510b2b78a78mr17708ede.5.1686689921506; Tue, 13 Jun
 2023 13:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com> <20230610005149.1145665-4-rmoar@google.com>
 <202306131324.5B69ABC@keescook>
In-Reply-To: <202306131324.5B69ABC@keescook>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 13 Jun 2023 16:58:30 -0400
Message-ID: <CA+GJov6FjojVU6FhbkFfosGQveqFG2a2fuc4Pw83Cs7dbhuhDw@mail.gmail.com>
Subject: Re: [RFC v1 3/6] kunit: Add ability to filter attributes
To:     Kees Cook <keescook@chromium.org>
Cc:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 13, 2023 at 4:26=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Sat, Jun 10, 2023 at 12:51:46AM +0000, Rae Moar wrote:
> > Add filtering of test attributes. Users can filter tests using a
> > module_param_array called "filter". This functionality will be added to
> > kunit.py in the next patch.
> >
> > The filters will be imputed in the format:
> > "<attribute_name><operation><attribute_value>"
> >
> > Example: "speed>slow"
> >
> > Operations include: >, <, >=3D, <=3D, !=3D, and =3D. These operations d=
o not need
> > to act the same for every attribute.
>
> How is the "default" filter specified? Is explicitly unfiltered? (i.e.
> "slow" stuff will run by default?) Or should there be a default filter
> of "speed<slow" for the memcpy conversion?
>
> But yes, I'm a fan of this whole series! I would much prefer this to
> having one-off CONFIGs for slow tests. :)
>

Hello!

Great to hear that you are happy to see this series.

Currently if no filter is specified, tests will run unfiltered (so the
slow tests will run by default).

But I think the idea of having a "default" filter is really
interesting. I would definitely be open to adding a default filter
that only runs tests with speeds faster than slow, which could then be
overridden by any filter input.

This also means there could be suite specific default filters but that
may be a future implementation since we currently only have one
attribute.

Or alternatively we could have a file that includes a list of default
filters that could then be inputted and altered based on suite.

Thanks!
Rae

> --
> Kees Cook
