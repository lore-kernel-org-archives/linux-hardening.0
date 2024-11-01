Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2612AAE2;
	Fri,  1 Nov 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473644; cv=none; b=KSv7UfngDB+Jm0J/ufxNNnfLSKR7yieJ4KR6OC2i9sO5skckC71UgAB6sX0Y5SCNx/3Xu8yix5Zwws6iW858Oh+1oRqf2GdKjW6mFxJZbJqDY5E6bfstAh1LjoGPxS9knZfeUaq0ALbDoZdR2a/VfcNxK/RYy+Doj8+CBB1vgbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473644; c=relaxed/simple;
	bh=1CRshPQ/zrg5K0whotrN4g47uqQqUTsO7G9dFqQ4LF8=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=SL9G1Mzfi8ipP/jDoJM3uj41E9b41aDbAXLSCJ8ejehfSAAMgD8aww1Z2gjKp800mkvLZScvaPPjngQ3mA3mE8YOT7MsWrYKjWAfcN5q0R+vB3STeWcV0jeqzKxBSCWw853OkGugSnY5lh+00OUkEetWhxmVQBsjc4Ir/FvfnZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:56846)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t6sSj-00HYXD-0r; Fri, 01 Nov 2024 08:17:17 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:57636 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t6sSh-00CKmw-Tj; Fri, 01 Nov 2024 08:17:16 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-hardening@vger.kernel.org
References: <20241031220833.work.539-kees@kernel.org>
Date: Fri, 01 Nov 2024 09:17:10 -0500
In-Reply-To: <20241031220833.work.539-kees@kernel.org> (Kees Cook's message of
	"Thu, 31 Oct 2024 15:08:35 -0700")
Message-ID: <875xp75995.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1t6sSh-00CKmw-Tj;;;mid=<875xp75995.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+HisLWAhTHexYH0dbla3AUbZ+0KqniI9A=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4527]
	*  0.0 XM_B_PhoneNumber BODY: Likely contains a phone number in body
	*      of email
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <kees@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 528 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (2.0%), b_tie_ro: 9 (1.8%), parse: 0.94 (0.2%),
	 extract_message_metadata: 14 (2.7%), get_uri_detail_list: 0.99 (0.2%),
	 tests_pri_-2000: 20 (3.8%), tests_pri_-1000: 2.3 (0.4%),
	tests_pri_-950: 1.18 (0.2%), tests_pri_-900: 0.97 (0.2%),
	tests_pri_-90: 313 (59.2%), check_bayes: 311 (58.9%), b_tokenize: 4.8
	(0.9%), b_tok_get_all: 154 (29.2%), b_comp_prob: 2.2 (0.4%),
	b_tok_touch_all: 146 (27.7%), b_finish: 1.01 (0.2%), tests_pri_0: 148
	(27.9%), check_dkim_signature: 0.48 (0.1%), check_dkim_adsp: 3.0
	(0.6%), poll_dns_idle: 0.98 (0.2%), tests_pri_10: 2.3 (0.4%),
	tests_pri_500: 12 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] MAINTAINERS: exec: Add auxvec.h UAPI
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, kees@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Kees Cook <kees@kernel.org> writes:

> Changes to auxiliary vectors would be best reviewed by the exec/binfmt
> maintainers.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>


> ---
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: linux-mm@kvack.org
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a097afd76ded..009501905386 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8501,6 +8501,7 @@ F:	fs/tests/binfmt_*_kunit.c
>  F:	fs/tests/exec_kunit.c
>  F:	include/linux/binfmts.h
>  F:	include/linux/elf.h
> +F:	include/uapi/linux/auxvec.h
>  F:	include/uapi/linux/binfmts.h
>  F:	include/uapi/linux/elf.h
>  F:	tools/testing/selftests/exec/
