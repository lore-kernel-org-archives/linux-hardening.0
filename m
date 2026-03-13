Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE633C53D;
	Fri, 13 Mar 2026 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393485; cv=none; b=hwbtIHG46Lk3KelswvevGtIQAqbbPtpc7pgIq1jhNBMDU+exHH8hl9gchva1ukQ/BpOy58SLHNhFImtThXPeL6qclKvV+mDtnBSryP+ixG6kcpTIeyZMmXP5UjoOdYQPZ+uQzVGOthSfUvDIIm9Ya+/uOq70Bza/pI6FHodLde4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393485; c=relaxed/simple;
	bh=EcyHN4pw9Uc2DlI5mhXLnzG8hORwCsRy5uZuxhkjT38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQaCPaPEMDwGVQ4aPKObLz8vjPOykF2R7hgN9xoCHfyc2jytb13jtLa/C4Fjj3tsNy1IHWllCsMQEMlyFnbXdVvpcNPZ73fPY66fJl0Svxa8Kger7QN6ktqKSCYxo1DgNpTGFPdk7uPyZcV0ZHCmxB0PE8EKfLtmk316Wbl/bDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx/oZyqN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx/oZyqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A505C19424;
	Fri, 13 Mar 2026 09:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773393484;
	bh=EcyHN4pw9Uc2DlI5mhXLnzG8hORwCsRy5uZuxhkjT38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bx/oZyqN5+WK2LBGz9mUk8VtR8Poq8EJxNdSdRgvI+5zMSkaWjS9hiYIRyC4kclhL
	 JNpK2vqczRxK4MjtF3s23up685uIBGTmSMmMvkAtb4LnT90GJmTFjzv8p85uULwfJw
	 3DycVkT1kfceFmzaqN2YZsRm3jdkUu25Rbeu/Iq17DCB9WDpCLAnTWNhVn9xNUAW2E
	 2Pyh0VFED8Rn6UulfHvwSVm8U7ZRRYez0/JCCpbRkqyvXjZ8AiIk1Dx8DjtbKYW2xh
	 3TcZojTi7fD+NY6s8SlhdwNaw/cGlpzX0SCcXYgAhhERDb3Cz06vnLpFrdrv9kiEXA
	 2f8p2DHydN6Xg==
Date: Fri, 13 Mar 2026 10:17:58 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Vincent Mailhol
 <mailhol@kernel.org>
Subject: Re: [PATCH v2 00/28] kernel-doc: use a C lexical tokenizer for
 transforms
Message-ID: <20260313101758.1dc691bc@foz.lan>
In-Reply-To: <cover.1773326442.git.mchehab+huawei@kernel.org>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jon,

On Thu, 12 Mar 2026 15:54:20 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Also, I didn't notice any relevant change on the documentation build
> time. 

After more tests, I actually noticed an issue after this changeset:

https://lore.kernel.org/linux-doc/2b957decdb6cedab4268f71a166c25b7abdb9a61.1773326442.git.mchehab+huawei@kernel.org/

Basically, a broken kernel-doc like this:

	
	/**
	 * enum dmub_abm_ace_curve_type - ACE curve type.
	 */
	enum dmub_abm_ace_curve_type {
	        /**
	         * ACE curve as defined by the SW layer.
	         */
	        ABM_ACE_CURVE_TYPE__SW = 0,
	        /**
	         * ACE curve as defined by the SW to HW translation interface layer.
	         */
	        ABM_ACE_CURVE_TYPE__SW_IF = 1,
	};

where the inlined markups don't have "@symbol" doesn't parse well. If
you run current kernel-doc, it would produce:

	.. c:enum:: dmub_abm_ace_curve_type

	  ACE curve type.

	.. container:: kernelindent

	    **Constants**

	    ``*/ ABM_ACE_CURVE_TYPE__SW = 0``
	      *undescribed*


	    `` */ ABM_ACE_CURVE_TYPE__SW_IF = 1``
	      *undescribed*

Because Kernel-doc currently drops the "/**" line. My fix patch
above fixes it, but inlined comments confuse enum/struct detection.
To avoid that, we need to strip comments earlier at dump_struct and
dump_enum:

	https://lore.kernel.org/linux-doc/d112804ace83e0ad8496f687977596bb7f091560.1773390831.git.mchehab+huawei@kernel.org/T/#u

After such fix, the output is now:

	.. c:enum:: dmub_abm_ace_curve_type

	  ACE curve type.

	.. container:: kernelindent

	    **Constants**

	    ``ABM_ACE_CURVE_TYPE__SW``
	      *undescribed*


	    ``ABM_ACE_CURVE_TYPE__SW_IF``
	      *undescribed*

which is the result expected when there's no proper inlined
kernel-doc markups.

Due to this issue, I ended adding a 29/28 patch on this series.

> With that regards, right now, every time a CMatch replacement
> rule takes in place, it does:
> 
>     for each transform:
>     - tokenizes the source code;
>     - handle CMatch;
>     - convert tokens back to a string.
> 
> A possible optimization would be to do, instead:
> 
>     - tokenizes source code;
>     - for each transform handle CMatch;
>     - convert tokens back to a string.
> 
> For now, I opted not do do it, because:
> 
>     - too much changes on a single row;
>     - docs build time is taking ~3:30 minutes, which is
>       about the same time it ws taken before the changes;
>     - there is a very dirty hack inside function_xforms:
>          (KernRe(r"_noprof"), ""). This is meant to change
>       function prototypes instead of function arguments.
> 
> So, if ok for you, I would prefer to merge this one first. We can later
> optimize kdoc_parser to avoid multiple token <-> string conversions.

I did such optimization and it worked fine. So, I ended adding
a 30/28 patch at the end. With that, running kernel-doc before/after
the entire series won't have significant performance changes.

	# Current approach
	$ time ./scripts/kernel-doc . -man >original 2>&1

	real    0m37.344s
	user    0m36.447s
	sys     0m0.712s

	# Tokenizer running multiple times (patch 29)
	$ time ./scripts/kernel-doc . -man >before 2>&1

	real    1m32.427s
	user    1m25.377s
	sys     0m1.293s

	# After optimization (patch 30)
	$ time ./scripts/kernel-doc . -man >after 2>&1

	real    0m47.094s
	user    0m46.106s
	sys     0m0.751s

10 seconds slower than before when parsing everything, which affects
make mandocs, but the time differences spent at kernel-doc parser during
make htmldocs is minimal: ir is about ~4 seconds(*):

	$  run_kdoc.py -none 2>/dev/null
	Checking what files are currently used on documentation...
	Running kernel-doc

	Elapsed time: 0:00:04.348008

(*) the slowest logic when building docs with Sphinx is inside its
    RST parser code.

See the enclosed script to see how I measured the parsing time for
existing ".. kernel-doc::" markups inside Documentation.


Thanks,
Mauro

---

This is the run_kdoc.py script I'm using here to pick the same files
as make htmldocs do:

#!/bin/env python3

import os
import re
import subprocess
import sys

from datetime import datetime
from glob import glob

print("Checking what files are currently used on documentation...")

kdoc_files = set()
re_kernel_doc = re.compile(r"^\.\.\s+kernel-doc::\s*(\S+)")

for fname in glob(os.path.join(".", "**"), recursive=True):
    if os.path.isfile(fname) and fname.endswith(".rst"):
        with open(fname, "r", encoding="utf-8") as in_fp:
            data = in_fp.read()

        for line in data.split("\n"):
            match = re_kernel_doc.match(line)
            if match:
                if os.path.isfile(match.group(1)):
                    kdoc_files.add(match.group(1))

if not kdoc_files:
    sys.exit(f"Directory doesn't contain kernel-doc tags")

cmd = [ "./tools/docs/kernel-doc" ]
cmd += sys.argv[1:]
cmd += sorted(kdoc_files)

print("Running kernel-doc")

start_time = datetime.now()

try:
    result = subprocess.run(cmd, check=True)
except subprocess.CalledProcessError as e:
    print(f"kernel-doc failed: {repr(e)}")

elapsed = datetime.now() - start_time
print(f"\nElapsed time: {elapsed}")



