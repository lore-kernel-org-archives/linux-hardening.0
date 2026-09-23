Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC98489FB0
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161651; cv=none; b=dmxZz0+Rw/FLgSpdTRZB7dN9MWr48UMgUoJ+q8KKZxUNF8E/tvp+yarazDQ+YfDQV5hgX5gsXwoHuC48+nLY5Nqq7uolyQprIeDK5Gn/3squsNYx+OEybHUxegMfv/4nV+wfbb8B7ahVzZ1Nr79pf8t/fwQLBkv0lRuzpyC0nUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161651; c=relaxed/simple;
	bh=pJ0kB+Bn0ty8Df9fzux0lXNg6lkK2n9yjz387iXwyhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LhWWELdHH1OFmXO3MEYUu3Uk+q4wqdEvaXsYvOo7kkkIqd8J4NzhjnLOXkZBsL0CO32m+OccqoBiaWYXKuI9WaA+1QfnySi4KygLQK5e5f2lQJanMs7wgN1rnEFx7iTYYd+oPV/ZB3BVeFvIetPIVQA318ePf2WicxN+Z+ozhfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UblevsNo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UblevsNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790161648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TJMczt8U7Il1GD5m7DtSdsfpcELN4wMeLzKtatEddHU=;
	b=UblevsNob96RpggecmvzaBJfeWJTOcm2Y/RET7oR9M7VqDUAZJywiPrxnIwWIvv2BI5D5r
	S6o++OrENK1AKsGQGTnaMyf2KxFwSdNwcPEjJkhMwyjz9ePFa5HoET0kI0LvPWudbJC36Y
	S9Var8MYGFtMujcx3+KFnc18s7790Q4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-_Bbwvj4PNpKWfqYbQKVdtw-1; Wed,
 23 Sep 2026 07:07:25 -0400
X-MC-Unique: _Bbwvj4PNpKWfqYbQKVdtw-1
X-Mimecast-MFC-AGG-ID: _Bbwvj4PNpKWfqYbQKVdtw_1790161641
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88FA3180A9F6;
	Wed, 23 Sep 2026 11:07:20 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 092F818002B6;
	Wed, 23 Sep 2026 11:07:10 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 23 Sep 2026 13:07:20 +0200 (CEST)
Date: Wed, 23 Sep 2026 13:07:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Kees Cook <kees@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, luto@amacapital.net,
	wad@chromium.org, peterz@infradead.org, ada.coupriediaz@arm.com,
	linusw@kernel.org, yeoreum.yun@arm.com, kevin.brodsky@arm.com,
	anshuman.khandual@arm.com, james.morse@arm.com, thuth@redhat.com,
	vladimir.murzin@arm.com, tglx@kernel.org, broonie@kernel.org,
	liqiang01@kylinos.cn, ryan.roberts@arm.com, pengcan@kylinos.cn,
	kmehltretter@gmail.com, linux-arm-kernel@lists.infradead.org,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests/ptrace: Add PTRACE_SYSEMU_SINGLESTEP
 syscall-exit-stop test
Message-ID: <arOy3YSkb9417Fo_@redhat.com>
References: <20260922195719.i.211-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260922195719.i.211-kees@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: wAh2N2tz3RtTCuYM4nZHy-P2E_58MQP7ElrB2SuuD8w_1790161641
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 09/22, Kees Cook wrote:
>
> ptrace(2) states that no syscall-exit-stop occurs when a tracee is
> continued with PTRACE_SYSEMU or PTRACE_SYSEMU_SINGLESTEP. arm64 gated
> its syscall-exit report on
>
> 	flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP)
>
> and ptrace_resume() clears SYSCALL_TRACE for both SYSEMU requests while
> PTRACE_SYSEMU_SINGLESTEP additionally sets TIF_SINGLESTEP, so the
> single-step bit alone produced a stop that must not exist. Nothing in
> tools/testing/selftests covered this.

IOW, this test-case veirifies that in the sequence like the generic code

	step = report_single_step(work);
	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
		arch_ptrace_report_syscall_exit(regs, step);

report_single_step() returns false, right? SYSCALL_TRACE is cleared by
the arch neutral code...

> Link: https://lore.kernel.org/all/20260922035510.1090299-2-ruanjinjie@huawei.com/ [1]
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  tools/testing/selftests/ptrace/Makefile       |   3 +-
>  .../selftests/ptrace/sysemu_singlestep.c      | 176 ++++++++++++++++++
>  tools/testing/selftests/ptrace/.gitignore     |   1 +
>  3 files changed, 179 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/ptrace/sysemu_singlestep.c

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

