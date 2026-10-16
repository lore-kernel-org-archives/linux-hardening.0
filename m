Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730145EF4E;
	Fri, 16 Oct 2026 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175729; cv=none; b=NHbODvAkbTAqDWO9xxkOHTgvJrIsdnCHhnd2XGxadR7gFloZEHejPCsVgkf8/AKzS1WJFBGamNQySciMTXy+VzjKl00CL9I/2RUB2s4dWHgGh8TByrXUnPzcnRm7mtHmEMRMvUmJW/KT1lan6z3ZdM9O5xXIli5W5ipk82PJtEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175729; c=relaxed/simple;
	bh=QWjv01i+N+E5bS7jcvQ/vtOBTs1zhQXtpGEiQF4EBMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTiN/Da/nxoKaxCf+ejcV8I6o7e17bUfwMKdEkKXEapDk0OQEuKTO0xc1WgtvTAbcHkm/u7VlCAKhbmBaQ60iyChMhpSg53VrZ6xteEjRT67cNMNb0M0GUjoV2tmRy0A+V8tntdbXUHT62JmYYzrsypqNrCd9yIaCKHO8Dnz0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=zDvptYke; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="zDvptYke"
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 450D0A81DC;
	Fri, 16 Oct 2026 18:35:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 0031E1C;
	Fri, 16 Oct 2026 18:35:22 +0000 (UTC)
Date: Fri, 16 Oct 2026 14:35:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow
 <david@davidgow.net>, Jiri Kosina <jikos@kernel.org>, Petr Mladek
 <pmladek@suse.com>, Shuvam Pandey <shuvampandey1@gmail.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 05/12] seq_buf: Clear what a writer did not claim
 when a seq_buf overflows
Message-ID: <20261016143521.6b4e439b@gandalf.local.home>
In-Reply-To: <20261005155708.1471260-5-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
	<20261005155708.1471260-5-kees@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0031E1C
X-Stat-Signature: dgkw88oubs1xq1bwf7gzfc197axo5kep
X-Rspamd-Server: rspamout01
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18NMWFSCLatJOSwfcWa3LzHTrgsg/GgwJE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=kNaeyd1jpCe3Q8kp7QvAvPjafgKnomdKJ3X64V18ZwQ=; b=zDvptYkeMjxfdXWpEWwQb57pGDppDFRNGaLh6ltl4bIIB5QrVCvtST1vr2c9neIbnkGJKLsFrO8muQ5QDIC3gog33At8OpZirjNWWdJ4s9dU2WyMRFaV1kQO2ePBD0OiSTW1kh8D8FH+VN6fwfF2kszlKgrMlSpMUAfKSLPq6nw=
X-HE-Tag: 1792175722-149224
X-HE-Meta: U2FsdGVkX1/b7i3Ami5PI4YwYP6/prSl4OV+TU45OHQDy1Que08CD1W2kSJhAmN/+1gO0Tou6B62IjYYtxFunT6hbBm0zjDjmJpQz822tvJqbkR7csCd9z0Q98dtMjguq6JyZtae9qbwTxPEQYuCT89farZWGXmopwJYblRSZkbI0aaRHqUGJamtV/A0yU1CQXzvDD++M+ku2Mjf9tHrFjFkYnPnkekPpmtNcCFtcJo14MPzNKn8sd82Lg+CMWVJ7Hq+hhHyC7NGzfaSQrOXe/0Al0ukok2oYLuMp+n+ahnxUV4VljfI4DcnF+sDI1jLXQZ/HLvhugLL0RmxKosvIdqRb9zx4rqz1FZTXOduZWWfV4OnzyvshlsLv7zv5geOUjn06Qx0qvqnFcjTLPJ5/4P1KPJ0riCkVul+jEgRH/5sohP6AatqxInj8ENaTtkJAGWMmenGD9c=

On Mon,  5 Oct 2026 08:56:55 -0700
Kees Cook <kees@kernel.org> wrote:

> Using seq_buf_set_overflow() would leave the bytes between "len"
> and "size" untouched, so if seq_buf_str() is used on an overflowed
> seq_buf, those bytes may be exposed. For any paths that don't claim
> partially written bytes, by setting "len = size" before calling
> seq_buf_set_overflow(), wipe the unclaimed bytes. The seq_buf_puts()
> and related APIs already claim those bytes now, so only the unclaimed
> cases remain. A specific example of this was seq_buf_path() which uses
> d_path() and would write to the tail before discovering it was out
> of space, and would correctly mark a seq_buf as overflowed, but the
> path fragment would be left over.
> 
> Clear from len to the end of the buffer in seq_buf_set_overflow(), which
> every overflow goes through, including seq_buf_commit() with a negative
> count.
> 
> Add a test that fills a seq_buf, leaves it too little room for a path, and
> checks that nothing of the path is left in the buffer. The tests run before
> anything writable is mounted, so it takes its file from shmem.
> 
> seq_buf_path() was not exported, so the test failed to link as a
> module. Export it.
> 
> Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
> and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.2.0, and the
> test builds as a module (CONFIG_SEQ_BUF_KUNIT_TEST=m).
> 
> Assisted-by: LLM
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
