Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4291AAE32;
	Fri,  1 Nov 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473316; cv=none; b=KVG0aVNpT51Uzksu8W0rtLeHdO3UdxY/vMS1vfYXUybGxoaGxna1YdyLiZGnNkUE8uds8VQoOx2jJdTiE7i+lUtAuMCjQTJCDnmpu0ZJFFuf3GpuPj0dOHwmkDP7ENX4H1ZJJkoPURwEtFXdGJqvoxcyNOEnIhRESoIcJlizsdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473316; c=relaxed/simple;
	bh=G/xXieC8du66dRVsENm0VyLzTazD90Ss7H045+8j1OA=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=s4Y0dCMgbThpkzjhFz4d2jvmhky0XnkmNLVCIF//AEo4m2Dpb/chY5dffwBkA2X6XLkk2CYyFbec48awKnaOb6jaLVZnK8f+qPRPLl5CszWr9T+xPY/Qx+ffTi6ysWbJmlMVS2twrwmINNxpkl4LXG0Y1xj3BFBXabu7EwvgHmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:34802)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t6sSM-00Dbw5-06; Fri, 01 Nov 2024 08:16:54 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:37426 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t6sSL-00CKfM-0o; Fri, 01 Nov 2024 08:16:53 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-hardening@vger.kernel.org
References: <20241031220853.work.354-kees@kernel.org>
Date: Fri, 01 Nov 2024 09:16:17 -0500
In-Reply-To: <20241031220853.work.354-kees@kernel.org> (Kees Cook's message of
	"Thu, 31 Oct 2024 15:08:55 -0700")
Message-ID: <87bjyz59am.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1t6sSL-00CKfM-0o;;;mid=<87bjyz59am.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX187lXHrxO2lQT2x/Os018rUWXKmsXZhyQk=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
	*      [score: 0.2381]
	*  0.0 XM_B_PhoneNumber BODY: Likely contains a phone number in body
	*      of email
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <kees@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 457 ms - load_scoreonly_sql: 0.08 (0.0%),
	signal_user_changed: 8 (1.7%), b_tie_ro: 7 (1.5%), parse: 0.87 (0.2%),
	extract_message_metadata: 22 (4.8%), get_uri_detail_list: 1.74 (0.4%),
	tests_pri_-2000: 30 (6.6%), tests_pri_-1000: 2.6 (0.6%),
	tests_pri_-950: 1.38 (0.3%), tests_pri_-900: 1.17 (0.3%),
	tests_pri_-90: 214 (46.7%), check_bayes: 212 (46.3%), b_tokenize: 6
	(1.2%), b_tok_get_all: 4.2 (0.9%), b_comp_prob: 1.76 (0.4%),
	b_tok_touch_all: 197 (43.1%), b_finish: 0.76 (0.2%), tests_pri_0: 165
	(36.2%), check_dkim_signature: 0.57 (0.1%), check_dkim_adsp: 2.9
	(0.6%), poll_dns_idle: 0.93 (0.2%), tests_pri_10: 2.1 (0.5%),
	tests_pri_500: 7 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] MAINTAINERS: exec: Mark Kees as maintainer
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, kees@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Kees Cook <kees@kernel.org> writes:

> It's more accurate to mark myself as a maintainer: I've been keeping the
> tree up to date in linux-next, etc.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

> ---
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: linux-mm@kvack.org
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 009501905386..c9cd99cd4a4b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8488,8 +8488,8 @@ F:	rust/kernel/net/phy.rs
>  F:	rust/kernel/net/phy/reg.rs
>  
>  EXEC & BINFMT API, ELF
> +M:	Kees Cook <kees@kernel.org>
>  R:	Eric Biederman <ebiederm@xmission.com>
> -R:	Kees Cook <kees@kernel.org>
>  L:	linux-mm@kvack.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
