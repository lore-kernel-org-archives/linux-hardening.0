Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90032571AD;
	Mon, 24 Feb 2025 23:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440342; cv=none; b=CNKnE300jNetCaFNKSZGtal0b02ARsRMxmzl1s3TW2W7+xb43G1YeAucvlvplhXl4UfUAZMKKBmgj0phGxnmhcw2j2QoWCmnJQzQq6RxtEibcqMOnPvZymTg4lr/oYcWda/lliHy2s57V99KWoGTS3ilRr0l6aDu4El3feF0xpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440342; c=relaxed/simple;
	bh=RgCmYK9gi130ysQ5PcJl5miCiVF3DEI9MQ+VVdRgBWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CZgV1w7eZ2kFJTr3DKzE3EW9u4a64s9elfGrY8jfja6T8afcnbyvTs3BdrjV9EsMTqHpgM/HDPrss+TChYZxFlUmD2tUinVVX4Y/mmZEyaAOs5YEEH6FyiUEaZ8R1iX86NEvHesr3AbPu4V+W87E2IkLqyM1OEDBewvSTqlU6Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=T3rOccTA; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="T3rOccTA"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BB8F848EBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1740440339; bh=SgLAVdrKZuX/W5L/F+iKWMkE38IgcN+piJNF+FMx5i8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=T3rOccTAYj15uacvW6+S5Z2QPKHin2fZLmvtaSPK81Io3B2193A2Ednp3xT+UX6aj
	 fuIriLwkL/b9MUG21cKKoeNPVmVXA1BG65cHFIf8bGjh6G/5P4LaBVYVkwLosnO9Ve
	 6DZWxu6j4zy54Q6Gv5CbanWCbuH2jtBCSKRfdU6BSHlrlgE20/M3V9FHYsyLeT6fOy
	 r9S13vTbapdxaE9vq6QQcdoV8nMtCy8+j9YQKsoLYbI9WOJDJ8JGTH5MCGNICDYnPG
	 4ToHVRGQgQkTOXFGYCBjTOmWmjV+Pzg45zRqNsS8MffXpjqRc9C+rICdlgCMcrWJO8
	 eZCLWHDzEhTCw==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BB8F848EBA;
	Mon, 24 Feb 2025 23:38:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Gustavo A. R. Silva"
 <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Kees Cook <mchehab+huawei@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/39] scripts/kernel-doc.py: add a Python parser
In-Reply-To: <3905b7386d5f1bfa76639cdf1108a46f0bccbbea.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
 <3905b7386d5f1bfa76639cdf1108a46f0bccbbea.1740387599.git.mchehab+huawei@kernel.org>
Date: Mon, 24 Feb 2025 16:38:58 -0700
Message-ID: <87v7sy29rh.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Maintaining kernel-doc has been a challenge, as there aren't many
> perl developers among maintainers. Also, the logic there is too
> complex. Having lots of global variables and using pure functions
> doesn't help.
>
> Rewrite the script in Python, placing most global variables
> inside classes. This should help maintaining the script in long
> term.

[...]

> diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
> new file mode 100755
> index 000000000000..5cf5ed63f215
> --- /dev/null
> +++ b/scripts/kernel-doc.py
> @@ -0,0 +1,2757 @@
> +#!/usr/bin/env python3
> +# pylint: disable=R0902,R0903,R0904,R0911,R0912,R0913,R0914,R0915,R0917,R1702
> +# pylint: disable=C0302,C0103,C0301
> +# pylint: disable=C0116,C0115,W0511,W0613
> +# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
> +# SPDX-License-Identifier: GPL-2.0

The SPDX tag is supposed to be up top, right under the shebang

I also think you should give consideration to preserving the other
copyright notices in the Perl version.  A language translation doesn't
remove existing copyrights...who knows how much creativity went into
some of those regexes?

> +# TODO: implement warning filtering
> +
> +"""
> +kernel_doc
> +==========
> +
> +Print formatted kernel documentation to stdout
> +
> +Read C language source or header FILEs, extract embedded
> +documentation comments, and print formatted documentation
> +to standard output.
> +
> +The documentation comments are identified by the "/**"
> +opening comment mark.
> +
> +See Documentation/doc-guide/kernel-doc.rst for the
> +documentation comment syntax.
> +"""
> +
> +import argparse
> +import logging
> +import os
> +import re
> +import sys
> +
> +from datetime import datetime
> +from pprint import pformat
> +
> +from dateutil import tz
> +
> +# Local cache for regular expressions
> +re_cache = {}
> +
> +
> +class Re:

So I have to say this bugs me a bit ... the class is fine, but the
one-letter case-only difference from the standard "re" class is just
going to make the code harder for others to approach.  "kern_re" or
something like that?  Or even "kre" if you really want it to be as short
as possible.

> +    """
> +    Helper class to simplify regex declaration and usage,
> +
> +    It calls re.compile for a given pattern. It also allows adding
> +    regular expressions and define sub at class init time.
> +
> +    Regular expressions can be cached via an argument, helping to speedup
> +    searches.
> +    """

[...]

> +
> +class KernelDoc:
> +    # Parser states
> +    STATE_NORMAL        = 0        # normal code
> +    STATE_NAME          = 1        # looking for function name
> +    STATE_BODY_MAYBE    = 2        # body - or maybe more description
> +    STATE_BODY          = 3        # the body of the comment
> +    STATE_BODY_WITH_BLANK_LINE = 4 # the body which has a blank line
> +    STATE_PROTO         = 5        # scanning prototype
> +    STATE_DOCBLOCK      = 6        # documentation block
> +    STATE_INLINE        = 7        # gathering doc outside main block
> +
> +    st_name = [
> +        "NORMAL",
> +        "NAME",
> +        "BODY_MAYBE",
> +        "BODY",
> +        "BODY_WITH_BLANK_LINE",
> +        "PROTO",
> +        "DOCBLOCK",
> +        "INLINE",
> +    ]

So these ... kind of look like enums?

That's kind of it for nits ... I do have one wish that will kind of hard
to grant overall ... for the long-term maintenance of this code, it
would be really nice if every non-trivial regex were described by a
comment explaining what it is trying to do.  It's not reasonable to
expect that as a condition for accepting this rewrite, but it sure would
be a nice goal to be working toward.

Thanks,

jon
