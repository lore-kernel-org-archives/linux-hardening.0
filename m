Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0334C10E5
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602226; cv=none; b=gQg3ajiygLky2g7me6wiVJ1AWv4xLrHzaL+fTX5hCzDWYvV6lSYfEuL7Mns0S1RdysQmDA6VnpHxp8kl7XRAELGPTrbaoO7XiFF403DIOpST3kx6GoYF5PAVNiH+WgVDmwUl35EjxDjKFtkAd80lwbKO5GAuEe6lTMWXAkp2yGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602226; c=relaxed/simple;
	bh=u4F+lc3vx+jYByWGzH3MQLi5+iszxVz9Dw6kvDqbkF0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=Rp1te07SRlwOxxXPKn/+KuyRwxdOjFvY3bXMvtr0YbHA+K+2S71fjoqro8Eytxoz0VsK2OG5VCaWKv+E1do1rjIyYyMP3kh5G1k4ow8W0z4IcgvhXe1cv9f42UrdyDJJuZ39aS8JJdxMjmpMiR+7At5Divc1ePl6SKmMVEoLVOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2wNPCkI; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2wNPCkI"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93c5b7f5bfaso159719485a.1
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 06:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602223; x=1791207023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xh2NHRfJCMfylFQd8bfgqsz1kSEX8TvOZMy0ZzkkjyY=;
        b=j2wNPCkIPr9VY64Ou+l1UKH4JEasIeLDhfuXps5KjDziKY0MBhMwSMBkLujCyyIeqh
         +IR/kE5K5ihWxaz2uuAQ1Zuek69IUSrvE4+xVFUKbOyZX7YLpvyKJglloMPSaZv4AnAG
         bQKxDS7tzeANVycaCJm+qgI5oQt0c1/1wacosE5hQIh+bhhHMc2quSBhq1sBcAGWMk5l
         6c8k8MOgM6pYRd0ZA2VRzi2Q1+u2/eKp44pVtkz2/xiXwDARznEM2FSLGzzOfbdCIw47
         wl2Vz4Qc4KYx+eIafnaLoKEqUVcUHWeYaiEhSyWQscYqnDizWF+zjvZgqp4VKxdeK4Zq
         w5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602223; x=1791207023;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xh2NHRfJCMfylFQd8bfgqsz1kSEX8TvOZMy0ZzkkjyY=;
        b=PFKNzWm8wOcSiukUnZU2rGo0RFRZ0zQqW1Q1GXcHcCBGFRnAdVzY0qmVwei8oqOy4t
         +ITeFPWtTMe8Kj7uHpsODS79srw8VW81Ajjpmfr8mwS+5jdlJ2B+IwwH3YbB2T1g3Owz
         4qDotaSXGJnZFq3C/es4fn/WxJtZ8itapEwdynGh4C2jfIsnkON6fo3tug19obU1GuWy
         SdIfe1vFR//3JjOwEYYZ1Oj549HibNWWvrz1HDZawBHZElQRdaA6mxz8jJnw+CtnncGk
         Seaw8i6/UFizTJ5OQT+O/y2r+mjSdkg3f4xHMIKfVKIiawY3Pwt3FrPuvS1B7Ymltke6
         wR6w==
X-Forwarded-Encrypted: i=1; AKwUvBxlMHWqDlfosL85rjytReFL1WJsUzYb4T2+0Xt1QN5xiOVruxE6FJTlQzZA6K8ZD4M81bTR5iqZBrb5RLBIe2I=@vger.kernel.org
X-Gm-Message-State: AFuF++k9cjNNLE1dq6SbAwpBWLYlzyWs4yNhS9SlO7puyw0HwkWg3lyr
	Ya6mEUSyd2MVwdLX/2n1jqm+Re/gvr2sktACUScEgUaOfAUs/hmI/MA4
X-Gm-Gg: AYBFou3oXFPy/ikSymYDuEBz4MNTKrJcBSu1+8Cq9/PUNA3Jck5jvh+MbHhyjMwdAFl
	stZGNUzcvCFAXMysSFupbBAujP25EY+kjPllwjzMtadN9uYBJhofX17Wu87bfVDBDHJIxinW0Pq
	cmdddgwpV75OoUJzQla9r9vSNwsfpiGKQXx2nyWGD1VAI/4c9h/dZuqvXU7iY29TL7C7S5n+2A6
	+BF34aEziDOzkM8ETZzwGp5Lx5k1zfLCCFo8wjLrtPtxb9rvxPJEr+dZypH8h4ry8/mPEZNjjht
	rVZebTvKLbzZ4nxpsWb+/DsGiYoRM3hhRdKpVO1a3A2C/ZeCL3AHjTZmnM9MX8InNQbG7x37EvJ
	hVuQuALk42KZgAa/AZzqsWJgag+eI6BBCg0cSVOBSD4SF3tLjvFgbp2041NaCJsQj6XaxcQGc70
	GWkI/827n+VKtTQ+tLVB7ugg9WDWwabbj/CwEVYdKJb6e4rSC3GxrD0fdgcjTSQGRIOigiWXBfr
	fd5h0T9WpUQD5eqOK8xe2T8UQy4g08G3QoYj67W0J/nmldqtx74Qw==
X-Received: by 2002:a05:620a:2888:b0:93a:ea:b00e with SMTP id af79cd13be357-93c43d9e0eemr2013943785a.30.1790602206503;
        Mon, 28 Sep 2026 06:30:06 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813a443fsm151650285a.12.2026.09.28.06.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:30:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, R Nageswara Sastry <rnsastry@linux.ibm.com>, Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org, stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: Re: [RESEND PATCH 1/3] KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
In-Reply-To: <20260928122837.8782-2-amachhiw@linux.ibm.com>
Date: Mon, 28 Sep 2026 18:57:16 +0530
Message-ID: <v77pjykr.ritesh.list@gmail.com>
References: <20260928122837.8782-1-amachhiw@linux.ibm.com> <20260928122837.8782-2-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> The virtual-mode HPT hcall handlers (H_ENTER, H_REMOVE, H_BULK_REMOVE,
> H_CLEAR_REF, H_CLEAR_MOD) call into book3s_hv_rm_mmu.c, which accesses
> memslots via kvm_memslots_raw().  kvm_memslots_raw() uses
> rcu_dereference_raw_check() to bypass SRCU lockdep annotation checking.
> This is safe in real mode because the entire guest entry/exit is wrapped
> in srcu_read_lock/unlock inside kvmppc_run_core() and
> kvmhv_run_single_vcpu().
>
> However, since commit 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual
> mode handlers for HPT hcalls and page faults"), these same handlers are
> also executed in virtual mode via kvmppc_pseries_do_hcall(), which runs
> after SRCU has already been released on guest exit.
>
> A concurrent KVM_SET_USER_MEMORY_REGION deletion or move can therefore
> call synchronize_srcu_expedited() — which does not wait for this thread —
> and then kfree(slot) and vfree(slot->arch.rmap) while the hcall handler
> still holds a raw pointer to the memslot.  lock_rmap() then writes to
> freed vmalloc memory, leading to use-after-free and memory corruption.
> Because kvm_memslots_raw() suppresses lockdep checks, this race is
> entirely silent.
>
> Fix this by factoring out the 7 HPT hcall handlers (H_REMOVE, H_ENTER,
> H_READ, H_CLEAR_MOD, H_CLEAR_REF, H_PROTECT, H_BULK_REMOVE) into a
> helper function, kvmppc_pseries_do_hpt_hcall(), and wrapping its call
> site in srcu_read_lock(&kvm->srcu) / srcu_read_unlock(&kvm->srcu, idx).
> Targeting only the HPT hcalls avoids wrapping non-HPT hcalls that sleep
> (such as H_CONFER, H_REGISTER_VPA, H_PAGE_INIT) or handlers that already
> acquire SRCU internally (such as H_RTAS).
>
> Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
> Cc: stable@vger.kernel.org # v5.14+
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 70 ++++++++++++++++++------------------
>  1 file changed, 35 insertions(+), 35 deletions(-)

I had looked at this path in depth earlier itself. LGTM.
Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
