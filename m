Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9552D2A1
	for <linux-hardening@vger.kernel.org>; Wed,  9 Sep 2026 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950344; cv=none; b=mfrCxbzHd7mVuZXIMCMCVqaSrK0fb42f6s7OSmdlbqNblqocrmnk4gZs5Dy+YUKK9HEVr5jCkJtXbyXYTcHz2z3o8ULEBVCum3EyWLfpgg+ySeaU91fWP9+38qgs09Gkw5iE6iCVl19apszpH9xJhYW8LzSUvSKs/AUKjZWRaM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950344; c=relaxed/simple;
	bh=YkloEnC0ZLgVBAr9ognXw8nBjhZnbuHMLQa1IYu83xI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Tm10Nkgpv78IaQ7tLVQn2ev7w0I9Qm4GLx2szwjrXMUiCjzwt90UFeObM0W/j1/UXva20Remjq80B42/NLONfsPako2OMu/3ozppQw8sON9XRvv1OyBS77JYs2RvT7ROIs742shoyCuBYHt8eSqVb0KyO21fpxACsRlZ0krxNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agd15jF5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agd15jF5"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso7174424a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 09 Sep 2026 03:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788950341; x=1789555141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=acKyLSiBa5vUJd8dKJMdIgaytIHA9Ytzui4Ses8+1M4=;
        b=agd15jF5pV+t6VYfGMxNLIuvoU5a+2dWkeOphLYJ58I1k/3h188CrpVF1iEs5BGHeG
         ZFdjchSfjlhjpG0i3t4IlgwJWIJhC/xifuyD2ys1RK+EZJ7j/FcfY5B9oTF4nlM4KjGA
         DN6v76dZCQVjs0WFLlcr+JyjCEKZ2QREeYy9KRBPqNOuCJrIs4pyQsI1nAxa9Ghdvq7T
         6sgKl/vWmFPf9E0DFJ8LwhtpfPbpK9GMrtQuavKD2XnR1seDWPls8HYzFuHYySgUxilL
         4uf7aO5Y8RU1Kjb304KIn3HFKxA030uL0rV+u4M50uuZM4p04OP0f+HVI2gYNmNJybSq
         GaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788950341; x=1789555141;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=acKyLSiBa5vUJd8dKJMdIgaytIHA9Ytzui4Ses8+1M4=;
        b=IBGJ6Nsey2g1/psfrzmwiJhs5JwhVagsjNAm25JGIAKJeoOnmHwvnnmBnbneAgmzDQ
         ixN9/2kUg3fHqRHJ1J4dDDKb8M2aqfOXBQ5z3pPEdiUbWVhrq3nZEXNhNQ2GsQ7ZguN9
         QVZh2JNwZozqKTARqMKN92g+CV4G/DY9K/MlE3XFt00UfbKO/B8hn6+w4iSp9rKIyG2i
         +eOCaQ+BAqYiF4CEltC02F++fSvuAN3RAAKUv0mfqKHuao+dXIOl7ppSMsV2RKmQvmi4
         Sopa1YEVtD+ZMd4GGgVPkv8efnjdVLo+dF6Bgh6l2236iOv//6dchS7knBv0HNl4+fX8
         8Ryg==
X-Forwarded-Encrypted: i=1; AKwUvBzqpOCBbfMX3SfFKz0Qf55wFB0DLjSfvIZa5UiXdA0ZS/R3Q62xuvmIywC725gekqCFhue+KFzqxYFva5lQPyo=@vger.kernel.org
X-Gm-Message-State: AFuF++kwfM4drnwiuSz+EtILidS/xuhRJoBap35RV9BTBJI1Nu2eiYPv
	5GVslZ1TCRzS5HpbbejCGaUoBysg/zUgQ+rfIM/ivdODbd5suoMUHgnB
X-Gm-Gg: AYBFou0mEEYt/Q+V4t6DFOJ6pCLP8bWJZ2MnUFYwdtYSMC8lWrOcmfwzYYK+EEjc8I7
	kPFeMD7Um6dCy+epaMFlCc818X1VAMSToBZxvH7KAnffmWBaC62kpVzEXeCuoD6+VQA+eTNmocE
	nD1uCxxJU/9V05GZrxPZIr5PeRBlW+CvfOyfwX4KWfIU+C23ABAIjre5svealAfxbuJgK+kwT9c
	XkbgwqfbKoSjE2fNgrAOFYfEPp2OvmbVBwuqV4+cWltMySZMqtsPbV+KWttnW2tLIct28NhlPCH
	FIhVljmUUi9ZvhPYDZzsiCPy7Hr5uVeP78MI6KRx4P++zE1S85xaYGDi/9bOk3nFWfDsRqXc6oG
	W8XtBpzJKi/xN2KoDeacK9FULPzNRZvT8DgomXuqsN1WGfqWTutCUOx9O8YVIqmK0Ak4P2ApQUg
	oYYx5cg3X17AJGb6KXK4zTBF2Dzpx5E8WEP5oIZtc/343PxVS9cpRuy/xcsNYvH7T6HNPZFz1Rh
	dVM5g==
X-Received: by 2002:a17:907:9485:b0:c25:541:fd3a with SMTP id a640c23a62f3a-c260c7b5cfemr1361234266b.7.1788950335902;
        Wed, 09 Sep 2026 03:38:55 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d6e1c93sm744470666b.63.2026.09.09.03.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:38:55 -0700 (PDT)
Date: Wed, 9 Sep 2026 13:38:51 +0300
From: Dan Carpenter <error27@gmail.com>
To: oe-kbuild@lists.linux.dev, Priyank Rathod <rathodpriyank@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v6] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR)
 support
Message-ID: <202608260405.gHL6gOJf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-pcie-lmt-v6-1-bab4ce233fa5@google.com>

Hi Priyank,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Priyank-Rathod/PCI-pcie-Add-PCIe-Lane-Margining-at-Receiver-LMR-support/20260824-223812
base:   0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
patch link:    https://lore.kernel.org/r/20260824-pcie-lmt-v6-1-bab4ce233fa5%40google.com
patch subject: [PATCH v6] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support
config: powerpc64-randconfig-r073-20260826 (https://download.01.org/0day-ci/archive/20260826/202608260405.gHL6gOJf-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.2.0
smatch: v0.5.0-9187-g5189e3fb

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202608260405.gHL6gOJf-lkp@intel.com/

smatch warnings:
drivers/pci/pcie/margin.c:1005 pci_lmr_exit() warn: variable dereferenced before check 'dev' (see line 1003)
drivers/pci/pcie/margin.c:1020 pci_suspend_lmr() warn: variable dereferenced before check 'dev' (see line 1018)
drivers/pci/pcie/margin.c:1056 pci_reset_lmr() warn: variable dereferenced before check 'dev' (see line 1054)

vim +/dev +1005 drivers/pci/pcie/margin.c

ecb76f560cf217 Priyank Rathod 2026-08-24  1001  void pci_lmr_exit(struct pci_dev *dev)
ecb76f560cf217 Priyank Rathod 2026-08-24  1002  {
ecb76f560cf217 Priyank Rathod 2026-08-24 @1003  	struct pci_margin_dev *mdev = dev->lmr;
                                                                                      ^^^^^
Dereference

ecb76f560cf217 Priyank Rathod 2026-08-24  1004  
ecb76f560cf217 Priyank Rathod 2026-08-24 @1005  	if (!dev || !mdev)
                                                            ^^^^
This check is too late.  It can likely be removed.  The other warnings
are the same.

ecb76f560cf217 Priyank Rathod 2026-08-24  1006  		return;
ecb76f560cf217 Priyank Rathod 2026-08-24  1007  
ecb76f560cf217 Priyank Rathod 2026-08-24  1008  	pci_suspend_lmr(dev);
ecb76f560cf217 Priyank Rathod 2026-08-24  1009  
ecb76f560cf217 Priyank Rathod 2026-08-24  1010  	pci_margin_debugfs_remove(mdev);
ecb76f560cf217 Priyank Rathod 2026-08-24  1011  	mutex_destroy(&mdev->lock);
ecb76f560cf217 Priyank Rathod 2026-08-24  1012  	kfree(mdev);
ecb76f560cf217 Priyank Rathod 2026-08-24  1013  	dev->lmr = NULL;
ecb76f560cf217 Priyank Rathod 2026-08-24  1014  }
ecb76f560cf217 Priyank Rathod 2026-08-24  1015  
ecb76f560cf217 Priyank Rathod 2026-08-24  1016  void pci_suspend_lmr(struct pci_dev *dev)
ecb76f560cf217 Priyank Rathod 2026-08-24  1017  {
ecb76f560cf217 Priyank Rathod 2026-08-24 @1018  	struct pci_margin_dev *mdev = dev->lmr;
ecb76f560cf217 Priyank Rathod 2026-08-24  1019  
ecb76f560cf217 Priyank Rathod 2026-08-24 @1020  	if (!dev || !mdev)
ecb76f560cf217 Priyank Rathod 2026-08-24  1021  		return;
ecb76f560cf217 Priyank Rathod 2026-08-24  1022  
ecb76f560cf217 Priyank Rathod 2026-08-24  1023  	guard(mutex)(&mdev->lock);
ecb76f560cf217 Priyank Rathod 2026-08-24  1024  	pci_lmr_disable_locked(mdev);
ecb76f560cf217 Priyank Rathod 2026-08-24  1025  }
ecb76f560cf217 Priyank Rathod 2026-08-24  1026  
ecb76f560cf217 Priyank Rathod 2026-08-24  1027  static void pci_lmr_reset_software_state_locked(struct pci_margin_dev *mdev)
ecb76f560cf217 Priyank Rathod 2026-08-24  1028  {
ecb76f560cf217 Priyank Rathod 2026-08-24  1029  	struct pci_dev *dev;
ecb76f560cf217 Priyank Rathod 2026-08-24  1030  	int i;
ecb76f560cf217 Priyank Rathod 2026-08-24  1031  
ecb76f560cf217 Priyank Rathod 2026-08-24  1032  	if (!mdev)
ecb76f560cf217 Priyank Rathod 2026-08-24  1033  		return;
ecb76f560cf217 Priyank Rathod 2026-08-24  1034  
ecb76f560cf217 Priyank Rathod 2026-08-24  1035  	lockdep_assert_held(&mdev->lock);
ecb76f560cf217 Priyank Rathod 2026-08-24  1036  
ecb76f560cf217 Priyank Rathod 2026-08-24  1037  	if (!mdev->enabled)
ecb76f560cf217 Priyank Rathod 2026-08-24  1038  		return;
ecb76f560cf217 Priyank Rathod 2026-08-24  1039  
ecb76f560cf217 Priyank Rathod 2026-08-24  1040  	dev = mdev->dev;
ecb76f560cf217 Priyank Rathod 2026-08-24  1041  
ecb76f560cf217 Priyank Rathod 2026-08-24  1042  	for (i = 0; i < mdev->num_lanes; i++) {
ecb76f560cf217 Priyank Rathod 2026-08-24  1043  		mdev->lanes[i].timing_val = 0;
ecb76f560cf217 Priyank Rathod 2026-08-24  1044  		mdev->lanes[i].voltage_val = 0;
ecb76f560cf217 Priyank Rathod 2026-08-24  1045  	}
ecb76f560cf217 Priyank Rathod 2026-08-24  1046  
ecb76f560cf217 Priyank Rathod 2026-08-24  1047  	pci_lmr_restore_aspm(mdev);
ecb76f560cf217 Priyank Rathod 2026-08-24  1048  	pm_runtime_put_sync(&dev->dev);
ecb76f560cf217 Priyank Rathod 2026-08-24  1049  	mdev->enabled = false;
ecb76f560cf217 Priyank Rathod 2026-08-24  1050  }
ecb76f560cf217 Priyank Rathod 2026-08-24  1051  
ecb76f560cf217 Priyank Rathod 2026-08-24  1052  void pci_reset_lmr(struct pci_dev *dev)
ecb76f560cf217 Priyank Rathod 2026-08-24  1053  {
ecb76f560cf217 Priyank Rathod 2026-08-24 @1054  	struct pci_margin_dev *mdev = dev->lmr;
ecb76f560cf217 Priyank Rathod 2026-08-24  1055  
ecb76f560cf217 Priyank Rathod 2026-08-24 @1056  	if (!dev || !mdev)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

